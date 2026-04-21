#!/bin/bash
set -e

# ============================================================
# English:
# This folder contains later SE placement ablation experiments.
# The goal is to study where SE should be inserted in the network, including
# backbone P4/P5/P3+P4+P5 placements and head fusion placements.
# Scripts in this folder:
# - run_sb_se_p4.sh: runs the ablation with SE only after the backbone P4 C3 block.
# - run_sb_se_p5.sh: runs the ablation with SE only after the backbone P5 C3 block.
# - run_sb_se_p3_p4_p5.sh: runs the ablation with SE after backbone P3, P4, and P5.
# - run_sb_se_head_p4.sh: runs the ablation with SE after the head P4 fusion block.
# - run_sb_se_head_p4_p5.sh: runs the ablation with SE after the head P4 and head P5 fusion blocks.
# - run_all.sh: runs all wrapper scripts in this folder sequentially.
#
# 中文：
# 本文件夹包含后续的 SE 插入位置消融实验。
# 目标是研究 SE 放在网络不同位置时的效果，包括 backbone 的 P4/P5/P3+P4+P5，以及 head 融合层位置。
# 本文件夹中的脚本说明：
# - run_sb_se_p4.sh：运行仅在 backbone 的 P4 C3 后加入 SE 的实验。
# - run_sb_se_p5.sh：运行仅在 backbone 的 P5 C3 后加入 SE 的实验。
# - run_sb_se_p3_p4_p5.sh：运行在 backbone 的 P3、P4、P5 位置都加入 SE 的实验。
# - run_sb_se_head_p4.sh：运行在 head 的 P4 融合后加入 SE 的实验。
# - run_sb_se_head_p4_p5.sh：运行在 head 的 P4 与 P5 融合后加入 SE 的实验。
# - run_all.sh：按顺序运行本文件夹中的所有包装脚本。
# ============================================================

if [ -f /opt/conda/bin/activate ]; then
  source /opt/conda/bin/activate base
fi

cd /workspace/dl_project/project_yolov5/yolov5

printf 'START: running run_sb_se_p4.sh ...\n'
printf '开始运行：run_sb_se_p4.sh ...\n'
bash shell_run/04_se_ablation/run_sb_se_p4.sh
printf 'DONE: run_sb_se_p4.sh finished.\n'
printf '已完成：run_sb_se_p4.sh\n'

printf 'START: running run_sb_se_p5.sh ...\n'
printf '开始运行：run_sb_se_p5.sh ...\n'
bash shell_run/04_se_ablation/run_sb_se_p5.sh
printf 'DONE: run_sb_se_p5.sh finished.\n'
printf '已完成：run_sb_se_p5.sh\n'

printf 'START: running run_sb_se_p3_p4_p5.sh ...\n'
printf '开始运行：run_sb_se_p3_p4_p5.sh ...\n'
bash shell_run/04_se_ablation/run_sb_se_p3_p4_p5.sh
printf 'DONE: run_sb_se_p3_p4_p5.sh finished.\n'
printf '已完成：run_sb_se_p3_p4_p5.sh\n'

printf 'START: running run_sb_se_head_p4.sh ...\n'
printf '开始运行：run_sb_se_head_p4.sh ...\n'
bash shell_run/04_se_ablation/run_sb_se_head_p4.sh
printf 'DONE: run_sb_se_head_p4.sh finished.\n'
printf '已完成：run_sb_se_head_p4.sh\n'

printf 'START: running run_sb_se_head_p4_p5.sh ...\n'
printf '开始运行：run_sb_se_head_p4_p5.sh ...\n'
bash shell_run/04_se_ablation/run_sb_se_head_p4_p5.sh
printf 'DONE: run_sb_se_head_p4_p5.sh finished.\n'
printf '已完成：run_sb_se_head_p4_p5.sh\n'
