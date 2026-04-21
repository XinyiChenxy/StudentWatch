from fastapi import FastAPI, File, UploadFile
from fastapi.responses import HTMLResponse, JSONResponse
import cv2
import numpy as np
import base64
from ultralytics import YOLO

app = FastAPI()

# ── Load model ──────────────────────────────────────────────
model = YOLO("./model/yolo26s_best.pt")

CONF_THRESHOLD = 0.3
IOU_THRESHOLD  = 0.45

# Class colors
COLORS = {
    "bowing_the_head":          (0, 165, 255),
    "learning_over_the_table":  (0, 0, 255),
    "reading":                  (0, 255, 0),
    "using_phone":              (255, 0, 0),
    "writing":                  (0, 255, 255),
}

# ── Inference function ──────────────────────────────────────
def run_inference(image_bytes):
    # Decode image
    nparr = np.frombuffer(image_bytes, np.uint8)
    img0  = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

    # Run inference
    result = model.predict(source=img0, conf=CONF_THRESHOLD, iou=IOU_THRESHOLD, verbose=False)[0]

    # Draw boxes + collect results
    detections = []
    boxes = result.boxes

    if boxes is not None and len(boxes):
        for xyxy, conf, cls in zip(
            boxes.xyxy.cpu().numpy(),
            boxes.conf.cpu().numpy(),
            boxes.cls.cpu().numpy(),
        ):
            class_name = model.names[int(cls)]
            label      = f"{class_name.replace('_', ' ')} {conf:.2f}"
            color      = COLORS.get(class_name, (0, 255, 0))

            detections.append({
                "label":      class_name.replace('_', ' '),
                "english":    class_name,
                "confidence": f"{conf * 100:.1f}%"
            })

            x1, y1, x2, y2 = map(int, xyxy)
            cv2.rectangle(img0, (x1, y1), (x2, y2), color, 2)
            cv2.putText(img0, label, (x1, y1 - 10),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.6, color, 2)

    # Encode back to base64
    _, buffer  = cv2.imencode('.jpg', img0)
    img_base64 = base64.b64encode(buffer).decode('utf-8')
    return detections, img_base64

# ── Routes ──────────────────────────────────────────────────
@app.get("/", response_class=HTMLResponse)
async def home():
    with open("index.html", encoding="utf-8") as f:
        return f.read()

@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    contents = await file.read()
    detections, img_b64 = run_inference(contents)
    return JSONResponse({
        "detections": detections,
        "image":      img_b64
    })
