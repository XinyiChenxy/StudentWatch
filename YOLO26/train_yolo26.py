from ultralytics import YOLO
import torch
from multiprocessing import freeze_support
from pathlib import Path

def main():
    ROOT = Path(__file__).resolve().parent
    
    EPOCH = 1000
    PATIENCE = 20
    BATCH_SIZE = 2
    IMG_SIZE = [720, 1280]

    if torch.cuda.is_available():
        DEVICE = 0
        print(f"GPU detected: {torch.cuda.get_device_name(0)}")
    else:
        DEVICE = "cpu"
        print("No GPU detected. Using CPU.")

    print("DEVICE =", DEVICE)

    model = YOLO("yolo26s.pt")
    model.train(
        data=str(ROOT / "StudentWatch_no_hr.yaml"),
        project=str(ROOT / "runs" / "detect"),

        imgsz=IMG_SIZE,
        hsv_h=0.015,
        hsv_s=0.7,
        hsv_v=0.4,
        degrees=5.0,
        translate=0.10,
        scale=0.30,
        shear=2.0,
        fliplr=0.5,
        mosaic=1.0,
        mixup=0.10,
        epochs=EPOCH,
        patience=PATIENCE,
        batch=BATCH_SIZE,
        device=DEVICE,
        workers=0,  # safer on Windows
    )

if __name__ == "__main__":
    freeze_support()
    main()