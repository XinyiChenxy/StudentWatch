# SE_CBAM Reproducibility Guide

This document explains how to reproduce all training experiments in `/workspace/dl_project/SE_CBAM`, including:
- environment setup (same baseline as `project_yolov5`)
- dataset locations and class definitions
- code structure
- exact training commands for each model/experiment

## 1) Environment Setup

### Note (important)
This project uses the same environment baseline as `project_yolov5`.
- Reference Dockerfile: `/workspace/dl_project/project_yolov5/Dockerfile`
- Reference requirements: `/workspace/dl_project/project_yolov5/yolov5/requirements.txt`

Do not use `/workspace/dl_project/project_yolov5/requirements.txt` (it is empty).

### Option A: Docker (recommended)

1. Build image from the baseline Dockerfile:

```bash
cd /workspace/dl_project/project_yolov5
docker build -t yolo-sb-baseline -f Dockerfile .
```

2. Run container and mount this project:

```bash
docker run --gpus all -it --rm \
  -v /workspace/dl_project/SE_CBAM:/workspace/dl_project/SE_CBAM \
  -w /workspace/dl_project/SE_CBAM/yolov5_CBAM \
  yolo-sb-baseline bash
```

### Option B: Local Conda/Python

```bash
conda create -n yolo_sb python=3.10 -y
conda activate yolo_sb
cd /workspace/dl_project/SE_CBAM/yolov5_CBAM
pip install -r /workspace/dl_project/project_yolov5/yolov5/requirements.txt
```

Set the same runtime flags used in scripts:

```bash
export YOLOv5_AUTOINSTALL=False
export YOLO_CONFIG_DIR=/tmp/Ultralytics
```

## 2) Project Structure

```text
/workspace/dl_project/SE_CBAM
├── dataset/
│   ├── sb/                  # 6-class StudentWatch
│   └── sb_no_hr/            # 5-class version (hand_raising removed)
├── _eval_sb_no_hr_as_6cls/  # remapped test set for 6-class-style evaluation
├── yolov5_CBAM/
│   ├── data/StudentWatch*.yaml
│   ├── data/hyps/hyp.sb_aug.yaml
│   ├── models/yolov5s.yaml
│   ├── models/yolov5s_cbam.yaml
│   ├── models/yolov5s_se.yaml
│   ├── train.py
│   ├── train_weighted_loss.py
│   ├── utils/weighted_loss.py
│   └── shell_run/*.sh
├── test_sb_no_hr.yaml
├── test_sb_no_hr_5cls.yaml
└── test_sb_no_hr_6cls.yaml
```

## 3) Dataset Locations and Splits

Training YAMLs used by scripts:
- `yolov5_CBAM/data/StudentWatch.yaml`
  - `path: /workspace/dl_project/SE_CBAM/dataset/sb`
  - `nc: 6`
- `yolov5_CBAM/data/StudentWatch_no_hr.yaml`
  - `path: /workspace/dl_project/SE_CBAM/dataset/sb_no_hr`
  - `nc: 5`

Split sizes in this workspace:
- `sb`: train 236 / valid 68 / test 34
- `sb_no_hr`: train 236 / valid 68 / test 34

Class names:
- 6-class (`sb`): `bowing_the_head`, `hand_raising`, `learning_over_the_table`, `reading`, `using_phone`, `writing`
- 5-class (`sb_no_hr`): `bowing_the_head`, `learning_over_the_table`, `reading`, `using_phone`, `writing`

### Note on YAML consistency
`dataset/sb_no_hr/data.yaml` still shows `nc: 6`, but training scripts do **not** use this file.  
Use `yolov5_CBAM/data/StudentWatch_no_hr.yaml` for correct 5-class training.

## 4) Models and Training Entrypoints

Model configs:
- `models/yolov5s.yaml`: standard YOLOv5s
- `models/yolov5s_cbam.yaml`: YOLOv5s + CBAM (main experiments)
- `models/yolov5s_se.yaml`: YOLOv5s + SE

Training scripts:
- `train.py`: standard YOLOv5 loss
- `train_weighted_loss.py`: weighted classification loss
  - implemented in `utils/weighted_loss.py`
  - uses fixed class counts `[94, 99, 782, 631, 329]` to build class weights

Shell scripts in `yolov5_CBAM/shell_run/`:
- `run_sb.sh`
- `run_sb_no_hr.sh`
- `run_sb_no_hr_aug.sh`
- `run_sb_no_hr_weighted.sh`
- `run_sb_no_hr_aug_weighted.sh`
- `run_sb_se.sh` (name says SE, but currently uses `models/yolov5s_cbam.yaml`)

## 5) 🚀 How to Run Experiments

## 📂 Step 1: Go to Project Directory

```bash
cd /workspace/dl_project/SE_CBAM/yolov5_CBAM
```

## Step 2: Run Each Experiment

### 1) CBAM baseline on 6-class dataset

```bash
bash shell_run/run_sb.sh
```

Equivalent core command:

```bash
python train.py --img 640 --batch 2 --epochs 1000 \
  --data data/StudentWatch.yaml \
  --cfg models/yolov5s_cbam.yaml \
  --weights yolov5s.pt \
  --workers 2 --cache \
  --project runs/train --name sb_cbam_baseline \
  --patience 0
```

### 2) CBAM on 5-class no-HR dataset

```bash
bash shell_run/run_sb_no_hr.sh
```

### 3) CBAM + stronger augmentation (no-HR)

```bash
bash shell_run/run_sb_no_hr_aug.sh
```

Uses:
- `data/StudentWatch_no_hr.yaml`
- `data/hyps/hyp.sb_aug.yaml`

### 4) CBAM + weighted loss (no-HR)

```bash
bash shell_run/run_sb_no_hr_weighted.sh
```

### 5) CBAM + augmentation + weighted loss (no-HR)

```bash
bash shell_run/run_sb_no_hr_aug_weighted.sh
```

### 6) Legacy `run_sb_se.sh`

```bash
bash shell_run/run_sb_se.sh
```

Current behavior: it still points to `models/yolov5s_cbam.yaml` (not `yolov5s_se.yaml`).

### 7) Run true SE model manually

```bash
python train.py --img 640 --batch 2 --epochs 1000 \
  --data data/StudentWatch.yaml \
  --cfg models/yolov5s_se.yaml \
  --weights yolov5s.pt \
  --workers 2 --cache \
  --project runs/train --name sb_se_baseline \
  --patience 0
```

### 8) Run vanilla YOLOv5s manually

```bash
python train.py --img 640 --batch 2 --epochs 1000 \
  --data data/StudentWatch.yaml \
  --cfg models/yolov5s.yaml \
  --weights yolov5s.pt \
  --workers 2 --cache \
  --project runs/train --name sb_vanilla_baseline \
  --patience 0
```

### 9) Run all packaged CBAM experiments in sequence

```bash
bash shell_run/runall.sh
```

Logs are saved under `yolov5_CBAM/run_logs/`.

## 6) Outputs and Checkpoints

For each run:
- run directory: `yolov5_CBAM/runs/train/<exp_name>/`
- options snapshot: `opt.yaml`
- hyperparameters snapshot: `hyp.yaml`
- checkpoints:
  - `weights/best.pt`
  - `weights/last.pt`

## 7) Optional Evaluation Commands

5-class evaluation on `sb_no_hr` test:

```bash
python val.py \
  --data /workspace/dl_project/SE_CBAM/test_sb_no_hr_5cls.yaml \
  --weights runs/train/sb_cbam_no_hr/weights/best.pt \
  --img 640 --task test
```

6-class-style evaluation using remapped dataset:

```bash
python val.py \
  --data /workspace/dl_project/SE_CBAM/test_sb_no_hr_6cls.yaml \
  --weights runs/train/sb_cbam_baseline/weights/best.pt \
  --img 640 --task test
```

## 8) Reproducibility Checklist

- Use the same environment baseline as `project_yolov5`.
- Use absolute dataset paths exactly as in `yolov5_CBAM/data/StudentWatch*.yaml`.
- Keep `--img 640 --batch 2 --epochs 1000 --workers 2 --cache --patience 0`.
- Keep `YOLOv5_AUTOINSTALL=False` and `YOLO_CONFIG_DIR=/tmp/Ultralytics`.
- Record `runs/train/*/opt.yaml` and `hyp.yaml` for each run.
