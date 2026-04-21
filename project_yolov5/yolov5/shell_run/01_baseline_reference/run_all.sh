#!/bin/bash
set -e

# ============================================================
# English:
# This folder contains reference baseline experiments.
# The goal is to establish the starting point before applying class-removal,
# augmentation, weighted loss, or SE-based architectural changes.
# Scripts in this folder:
# - run_sb.sh: runs the original StudentWatch baseline with the full class set.
# - run_all.sh: runs all wrapper scripts in this folder sequentially.
#
# 中文：
# 本文件夹包含基线参考实验。
# 目标是在引入删类、数据增强、加权损失、SE 结构修改之前，先建立原始对照结果。
# 本文件夹中的脚本说明：
# - run_sb.sh：运行原始 StudentWatch 全类别基线实验。
# - run_all.sh：按顺序运行本文件夹中的所有包装脚本。
# ============================================================

if [ -f /opt/conda/bin/activate ]; then
  source /opt/conda/bin/activate base
fi

cd /workspace/dl_project/project_yolov5/yolov5

printf 'START: running run_sb.sh ...\n'
printf '开始运行：run_sb.sh ...\n'
bash shell_run/01_baseline_reference/run_sb.sh
printf 'DONE: run_sb.sh finished.\n'
printf '已完成：run_sb.sh\n'
