#!/bin/bash
set -e

if [ -f /opt/conda/bin/activate ]; then
  source /opt/conda/bin/activate base
fi

cd /workspace/dl_project/project_yolov5/yolov5

printf 'START: running category 01_baseline_reference ...\n'
printf '开始运行：01_baseline_reference ...\n'
bash shell_run/01_baseline_reference/run_all.sh
printf 'DONE: 01_baseline_reference finished.\n'
printf '已完成：01_baseline_reference\n'

printf 'START: running category 02_data_imbalance_handling ...\n'
printf '开始运行：02_data_imbalance_handling ...\n'
bash shell_run/02_data_imbalance_handling/run_all.sh
printf 'DONE: 02_data_imbalance_handling finished.\n'
printf '已完成：02_data_imbalance_handling\n'

printf 'START: running category 03_se_imbalance_handling ...\n'
printf '开始运行：03_se_imbalance_handling ...\n'
bash shell_run/03_se_imbalance_handling/run_all.sh
printf 'DONE: 03_se_imbalance_handling finished.\n'
printf '已完成：03_se_imbalance_handling\n'

printf 'START: running category 04_se_ablation ...\n'
printf '开始运行：04_se_ablation ...\n'
bash shell_run/04_se_ablation/run_all.sh
printf 'DONE: 04_se_ablation finished.\n'
printf '已完成：04_se_ablation\n'
