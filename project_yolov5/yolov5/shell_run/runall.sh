#!/bin/bash
set -e

echo "===== Activate environment ====="
source /opt/conda/bin/activate base

# ⭐ 一定要切到 yolov5 根目录
cd /workspace/dl_project/project_yolov5/yolov5

echo "===== START ALL EXPERIMENTS ====="

echo "===== 1. Baseline ====="
bash shell_run/run_sb.sh > logs/sb_baseline.log 2>&1
echo "===== DONE: Baseline ====="

echo "===== 2. No HR ====="
bash shell_run/run_sb_no_hr.sh > logs/sb_no_hr.log 2>&1
echo "===== DONE: No HR ====="

echo "===== 3. Weighted ====="
bash shell_run/run_sb_no_hr_weighted.sh > logs/sb_no_hr_weighted.log 2>&1
echo "===== DONE: Weighted ====="

echo "===== 4. Aug ====="
bash shell_run/run_sb_no_hr_aug.sh > logs/sb_no_hr_aug.log 2>&1
echo "===== DONE: Aug ====="

echo "===== 5. Aug + Weighted ====="
bash shell_run/run_sb_no_hr_aug_weighted.sh > logs/sb_no_hr_aug_weighted.log 2>&1
echo "===== DONE: Aug + Weighted ====="

echo "===== 🎉 ALL DONE ====="