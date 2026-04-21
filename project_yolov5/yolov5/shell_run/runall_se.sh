#!/bin/bash
set -e

echo "===== Activate environment ====="
source /opt/conda/bin/activate base

# ⭐ 切到 yolov5 根目录
cd /workspace/dl_project/project_yolov5/yolov5

echo "===== START SE EXPERIMENTS ====="

echo "===== 1. SE + Drop HR ====="
bash shell_run/run_se_NOhr.sh > logs/se_no_hr.log 2>&1
echo "===== DONE: SE + Drop HR ====="

echo "===== 2. SE + Drop HR + Aug ====="
bash shell_run/run_se_NOhr_aug.sh > logs/se_no_hr_aug.log 2>&1
echo "===== DONE: SE + Drop HR + Aug ====="

echo "===== 3. SE + Drop HR + Weighted ====="
bash shell_run/run_se_NOhr_weighted.sh > logs/se_no_hr_weighted.log 2>&1
echo "===== DONE: SE + Drop HR + Weighted ====="

echo "===== 4. SE + Drop HR + Aug + Weighted ====="
bash shell_run/run_se_NOhr_aug_weighted.sh > logs/se_no_hr_aug_weighted.log 2>&1
echo "===== DONE: SE + Drop HR + Aug + Weighted ====="

echo "===== 🎉 ALL SE EXPERIMENTS DONE ====="