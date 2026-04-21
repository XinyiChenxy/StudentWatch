#!/bin/bash
# Run all newly added SE placement ablation experiments sequentially.
set -e

cd /workspace/dl_project/project_yolov5/yolov5

bash shell_run/run_sb_se_p4.sh
bash shell_run/run_sb_se_p5.sh
bash shell_run/run_sb_se_p3_p4_p5.sh
bash shell_run/run_sb_se_head_p4.sh
bash shell_run/run_sb_se_head_p4_p5.sh
