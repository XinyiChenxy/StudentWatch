#!/bin/bash
set -e

# ============================================================
# English:
# This folder contains experiments for handling class imbalance without SE.
# The goal is to study how removing the rare hand_raising class, adding data
# augmentation, and using weighted loss affect the baseline detector.
# Scripts in this folder:
# - run_sb_no_hr.sh: runs the baseline model after dropping the hand_raising class.
# - run_sb_no_hr_weighted.sh: runs the no-hr baseline with weighted loss.
# - run_sb_no_hr_aug.sh: runs the no-hr baseline with stronger augmentation.
# - run_sb_no_hr_aug_weighted.sh: runs the no-hr baseline with augmentation and weighted loss.
# - run_all.sh: runs all wrapper scripts in this folder sequentially.
#
# 中文：
# 本文件夹包含不使用 SE 的类别不平衡处理实验。
# 目标是研究删除稀有 hand_raising 类别、加入数据增强、以及使用加权损失后，对基线检测器的影响。
# 本文件夹中的脚本说明：
# - run_sb_no_hr.sh：运行删除 hand_raising 类别后的基础模型实验。
# - run_sb_no_hr_weighted.sh：运行删除 hand_raising 后并使用加权损失的实验。
# - run_sb_no_hr_aug.sh：运行删除 hand_raising 后并使用更强数据增强的实验。
# - run_sb_no_hr_aug_weighted.sh：运行删除 hand_raising 后同时使用数据增强与加权损失的实验。
# - run_all.sh：按顺序运行本文件夹中的所有包装脚本。
# ============================================================

if [ -f /opt/conda/bin/activate ]; then
  source /opt/conda/bin/activate base
fi

cd /workspace/dl_project/project_yolov5/yolov5

printf 'START: running run_sb_no_hr.sh ...\n'
printf '开始运行：run_sb_no_hr.sh ...\n'
bash shell_run/02_data_imbalance_handling/run_sb_no_hr.sh
printf 'DONE: run_sb_no_hr.sh finished.\n'
printf '已完成：run_sb_no_hr.sh\n'

printf 'START: running run_sb_no_hr_weighted.sh ...\n'
printf '开始运行：run_sb_no_hr_weighted.sh ...\n'
bash shell_run/02_data_imbalance_handling/run_sb_no_hr_weighted.sh
printf 'DONE: run_sb_no_hr_weighted.sh finished.\n'
printf '已完成：run_sb_no_hr_weighted.sh\n'

printf 'START: running run_sb_no_hr_aug.sh ...\n'
printf '开始运行：run_sb_no_hr_aug.sh ...\n'
bash shell_run/02_data_imbalance_handling/run_sb_no_hr_aug.sh
printf 'DONE: run_sb_no_hr_aug.sh finished.\n'
printf '已完成：run_sb_no_hr_aug.sh\n'

printf 'START: running run_sb_no_hr_aug_weighted.sh ...\n'
printf '开始运行：run_sb_no_hr_aug_weighted.sh ...\n'
bash shell_run/02_data_imbalance_handling/run_sb_no_hr_aug_weighted.sh
printf 'DONE: run_sb_no_hr_aug_weighted.sh finished.\n'
printf '已完成：run_sb_no_hr_aug_weighted.sh\n'
