#!/bin/bash
set -e

export YOLOv5_AUTOINSTALL=False
export YOLO_CONFIG_DIR=/tmp/Ultralytics

cd /workspace/dl_project/project_yolov5/yolov5

python train.py \
  --img 640 \
  --batch 2 \
  --epochs 1000 \
  --data data/StudentWatch_no_hr.yaml \
  --cfg models/yolov5s.yaml \
  --weights yolov5s.pt \
  --workers 2 \
  --cache \
  --project runs/train \
  --name sb_no_hr \
  --patience 0