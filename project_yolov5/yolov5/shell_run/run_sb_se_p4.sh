#!/bin/bash
# Run SE ablation with SE inserted only after the backbone P4 C3 block.
set -e

export YOLOv5_AUTOINSTALL=False
export YOLO_CONFIG_DIR=/tmp/Ultralytics

cd /workspace/dl_project/project_yolov5/yolov5

python train.py \
  --img 640 \
  --batch 2 \
  --epochs 1000 \
  --data data/StudentWatch_no_hr.yaml \
  --cfg models/yolov5s_se_p4.yaml \
  --weights yolov5s.pt \
  --workers 2 \
  --cache \
  --project runs/train \
  --name sb_se_p4_no_hr \
  --patience 0
