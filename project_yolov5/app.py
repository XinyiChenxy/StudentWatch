from fastapi import FastAPI, File, UploadFile
from fastapi.responses import HTMLResponse, JSONResponse
from pathlib import Path
import torch
import sys
import cv2
import numpy as np
import base64
import re
from datetime import datetime

# 把 yolov5 加入路径
BASE_DIR = Path(__file__).resolve().parent
UPLOAD_DIR = BASE_DIR / "uploads"
ORIGINAL_DIR = UPLOAD_DIR / "original"
RESULT_DIR = UPLOAD_DIR / "results"
ORIGINAL_DIR.mkdir(parents=True, exist_ok=True)
RESULT_DIR.mkdir(parents=True, exist_ok=True)

sys.path.insert(0, str(BASE_DIR / 'yolov5'))
from models.common import DetectMultiBackend
from utils.general import non_max_suppression, scale_boxes
from utils.augmentations import letterbox

app = FastAPI()

# ── 载入模型 ────────────────────────────────────────────────
model = DetectMultiBackend(
    str(BASE_DIR / 'yolov5/runs/train/sb_se_p3_p4_p5_no_hr_weighted/weights/best.pt'),
    device=torch.device('cpu')
)
model.eval()

CONF_THRESHOLD = 0.4
IOU_THRESHOLD  = 0.45

# 类别颜色
COLORS = {
    "bowing_the_head":          (0, 165, 255),
    "learning_over_the_table":  (0, 0, 255),
    "reading":                  (0, 255, 0),
    "using_phone":              (255, 0, 0),
    "writing":                  (255, 255, 0),
}

def safe_filename(filename):
    stem = Path(filename or "upload").stem
    suffix = Path(filename or "").suffix.lower()
    stem = re.sub(r"[^A-Za-z0-9_.-]+", "_", stem).strip("._")
    if suffix not in {".jpg", ".jpeg", ".png", ".bmp", ".webp"}:
        suffix = ".jpg"
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S_%f")
    return f"{timestamp}_{stem or 'upload'}{suffix}"

# ── 推理函数 ────────────────────────────────────────────────
def run_inference(image_bytes):
    # 解码图片
    nparr = np.frombuffer(image_bytes, np.uint8)
    img0  = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    if img0 is None:
        raise ValueError("Invalid image file")

    # 预处理
    img = letterbox(img0, 640, stride=model.stride, auto=True)[0]
    img = img.transpose((2, 0, 1))[::-1]
    img = np.ascontiguousarray(img)
    img = torch.from_numpy(img).float() / 255.0
    if img.ndimension() == 3:
        img = img.unsqueeze(0)

    # 推理
    with torch.no_grad():
        pred = model(img)
    pred = non_max_suppression(pred, CONF_THRESHOLD, IOU_THRESHOLD)

    # 画框 + 收集结果
    results = []

    for det in pred:
        if len(det):
            det[:, :4] = scale_boxes(img.shape[2:], det[:, :4], img0.shape).round()
            for *xyxy, conf, cls in det:
                class_name = model.names[int(cls)]
                label      = f"{class_name.replace('_', ' ')} {conf:.2f}"
                color      = COLORS.get(class_name, (0, 255, 0))

                results.append({
                    "label":      class_name.replace('_', ' '),
                    "english":    class_name,
                    "confidence": f"{conf * 100:.1f}%"
                })

                x1, y1, x2, y2 = map(int, xyxy)
                cv2.rectangle(img0, (x1, y1), (x2, y2), color, 2)
                cv2.putText(img0, label, (x1, y1 - 10),
                            cv2.FONT_HERSHEY_SIMPLEX, 0.6, color, 2)

    # 编码回 base64
    _, buffer  = cv2.imencode('.jpg', img0)
    img_base64 = base64.b64encode(buffer).decode('utf-8')
    return results, img_base64, buffer

# ── 路由 ────────────────────────────────────────────────────
@app.get("/", response_class=HTMLResponse)
async def home():
    with open(BASE_DIR / "index.html", encoding="utf-8") as f:
        return f.read()

@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    contents = await file.read()
    filename = safe_filename(file.filename)
    original_path = ORIGINAL_DIR / filename
    result_path = RESULT_DIR / f"{Path(filename).stem}_result.jpg"

    original_path.write_bytes(contents)

    try:
        detections, img_b64, result_buffer = run_inference(contents)
    except ValueError as exc:
        original_path.unlink(missing_ok=True)
        return JSONResponse({"error": str(exc)}, status_code=400)

    result_path.write_bytes(result_buffer.tobytes())

    return JSONResponse({
        "detections": detections,
        "image":      img_b64,
        "saved_original": str(original_path.relative_to(BASE_DIR)),
        "saved_result": str(result_path.relative_to(BASE_DIR)),
    })
