#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DIR="${ROOT_DIR}/run_logs"
mkdir -p "${LOG_DIR}"

echo "===== Environment Ready ====="

# Always run from this repository root.
cd "${ROOT_DIR}"

echo "===== START ALL EXPERIMENTS ====="

echo "===== 1. Baseline ====="
bash shell_run/run_sb.sh > "${LOG_DIR}/sb_baseline.log" 2>&1
echo "===== DONE: Baseline ====="

echo "===== 2. No HR (Fixing Imbalance) ====="
bash shell_run/run_sb_no_hr.sh > "${LOG_DIR}/sb_no_hr.log" 2>&1
echo "===== DONE: No HR ====="

echo "===== 3. Weighted Loss ====="
bash shell_run/run_sb_no_hr_weighted.sh > "${LOG_DIR}/sb_no_hr_weighted.log" 2>&1
echo "===== DONE: Weighted ====="

echo "===== 4. Augmentation (Best Potential) ====="
bash shell_run/run_sb_no_hr_aug.sh > "${LOG_DIR}/sb_no_hr_aug.log" 2>&1
echo "===== DONE: Aug ====="

echo "===== 5. Aug + Weighted ===== "
bash shell_run/run_sb_no_hr_aug_weighted.sh > "${LOG_DIR}/sb_no_hr_aug_weighted.log" 2>&1
echo "===== DONE: Aug + Weighted ====="

echo "===== ALL DONE ====="
