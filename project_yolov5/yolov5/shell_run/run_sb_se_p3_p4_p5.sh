#!/bin/bash
# Run SE ablation with SE inserted after the backbone P3, P4, and P5 C3 blocks.
set -e

export YOLOv5_AUTOINSTALL=False
export YOLO_CONFIG_DIR=/tmp/Ultralytics

cd /workspace/dl_project/project_yolov5/yolov5

python train.py \
  --img 640 \
  --batch 2 \
  --epochs 1000 \
  --data data/StudentWatch_no_hr.yaml \
  --cfg models/yolov5s_se_p3_p4_p5.yaml \
  --weights yolov5s.pt \
  --workers 2 \
  --cache \
  --project runs/train \
  --name sb_se_p3_p4_p5_no_hr \
  --patience 0
