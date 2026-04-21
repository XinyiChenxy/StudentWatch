#!/bin/bash
set -e

# ============================================================
# English:
# This folder contains SE-based experiments for handling class imbalance.
# The goal is to study whether adding SE to the backbone improves the no-hr,
# augmentation, and weighted-loss strategies used in the imbalance stage.
# Scripts in this folder:
# - run_se_NOhr.sh: runs the SE model after dropping the hand_raising class.
# - run_se_NOhr_weighted.sh: runs the SE no-hr model with weighted loss.
# - run_se_NOhr_aug.sh: runs the SE no-hr model with stronger augmentation.
# - run_se_NOhr_aug_weighted.sh: runs the SE no-hr model with augmentation and weighted loss.
# - run_all.sh: runs all wrapper scripts in this folder sequentially.
#
# 中文：
# 本文件夹包含基于 SE 的类别不平衡处理实验。
# 目标是研究在删去 hand_raising 类别后，加入 SE 是否能进一步提升基础方案、数据增强方案和加权损失方案。
# 本文件夹中的脚本说明：
# - run_se_NOhr.sh：运行加入 SE 且删除 hand_raising 类别后的实验。
# - run_se_NOhr_weighted.sh：运行加入 SE、删除 hand_raising 后并使用加权损失的实验。
# - run_se_NOhr_aug.sh：运行加入 SE、删除 hand_raising 后并使用更强数据增强的实验。
# - run_se_NOhr_aug_weighted.sh：运行加入 SE、删除 hand_raising 后同时使用数据增强与加权损失的实验。
# - run_all.sh：按顺序运行本文件夹中的所有包装脚本。
# ============================================================

if [ -f /opt/conda/bin/activate ]; then
  source /opt/conda/bin/activate base
fi

cd /workspace/dl_project/project_yolov5/yolov5

printf 'START: running run_se_NOhr.sh ...\n'
printf '开始运行：run_se_NOhr.sh ...\n'
bash shell_run/03_se_imbalance_handling/run_se_NOhr.sh
printf 'DONE: run_se_NOhr.sh finished.\n'
printf '已完成：run_se_NOhr.sh\n'

printf 'START: running run_se_NOhr_weighted.sh ...\n'
printf '开始运行：run_se_NOhr_weighted.sh ...\n'
bash shell_run/03_se_imbalance_handling/run_se_NOhr_weighted.sh
printf 'DONE: run_se_NOhr_weighted.sh finished.\n'
printf '已完成：run_se_NOhr_weighted.sh\n'

printf 'START: running run_se_NOhr_aug.sh ...\n'
printf '开始运行：run_se_NOhr_aug.sh ...\n'
bash shell_run/03_se_imbalance_handling/run_se_NOhr_aug.sh
printf 'DONE: run_se_NOhr_aug.sh finished.\n'
printf '已完成：run_se_NOhr_aug.sh\n'

printf 'START: running run_se_NOhr_aug_weighted.sh ...\n'
printf '开始运行：run_se_NOhr_aug_weighted.sh ...\n'
bash shell_run/03_se_imbalance_handling/run_se_NOhr_aug_weighted.sh
printf 'DONE: run_se_NOhr_aug_weighted.sh finished.\n'
printf '已完成：run_se_NOhr_aug_weighted.sh\n'
