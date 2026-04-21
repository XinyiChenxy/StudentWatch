#!/bin/bash
set -e

# ============================================================
# English:
# This folder contains follow-up experiments that combine the best current SE
# ablation result with the best current imbalance-handling method.
# The goal is to test whether the strongest SE placement (P3+P4+P5 backbone)
# can gain additional improvement when weighted loss is added on the no_hr setup.
# Scripts in this folder:
# - run_sb_se_p3_p4_p5_weighted.sh: runs the P3+P4+P5 SE backbone model with weighted loss on StudentWatch_no_hr.
# - run_all.sh: runs all wrapper scripts in this folder sequentially.
#
# 中文：
# 本文件夹包含一个后续跟进实验：将当前最优的 SE 消融结构，和当前最优的类别不平衡处理方法组合起来。
# 目标是验证：在 no_hr 设定下，backbone 的 P3+P4+P5 插入 SE 后，再加入 weighted loss，是否还能进一步提升效果。
# 本文件夹中的脚本说明：
# - run_sb_se_p3_p4_p5_weighted.sh：运行 backbone P3+P4+P5 加入 SE，并结合 weighted loss 的 StudentWatch_no_hr 实验。
# - run_all.sh：按顺序运行本文件夹中的所有包装脚本。
# ============================================================

if [ -f /opt/conda/bin/activate ]; then
  source /opt/conda/bin/activate base
fi

cd /workspace/dl_project/project_yolov5/yolov5

printf 'START: running run_sb_se_p3_p4_p5_weighted.sh ...\n'
printf '开始运行：run_sb_se_p3_p4_p5_weighted.sh ...\n'
bash shell_run/05_se_weighted_followup/run_sb_se_p3_p4_p5_weighted.sh
printf 'DONE: run_sb_se_p3_p4_p5_weighted.sh finished.\n'
printf '已完成：run_sb_se_p3_p4_p5_weighted.sh\n'
