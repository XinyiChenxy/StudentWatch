# YOLOv5 StudentWatch Experiments (Baseline, Imbalance Handling, and SE Ablations)

This repository contains reproducible training pipelines for:
- Baseline YOLOv5s training on StudentWatch
- Class-imbalance handling (drop `hand_raising`, augmentation, weighted loss)
- SE-enhanced models
- SE placement ablations (backbone vs head)

The goal of this README is to let any user reproduce your experiments end-to-end.

## 1) Environment Setup

### Step 1. Go to the training code directory

Use your local path:

```bash
cd /home/xinyic/dl_project/project_yolov5/yolov5
```

Or in this workspace:

```bash
cd /workspace/dl_project/project_yolov5/yolov5
```

### Step 2. Create/activate Python environment

If you use conda:

```bash
conda create -n yolo_sb python=3.10 -y
conda activate yolo_sb
```

If your machine already uses the base conda env (as in provided scripts):

```bash
source /opt/conda/bin/activate base
```

### Step 3. Install dependencies

Install from the YOLOv5 requirements file (the top-level `requirements.txt` is empty in this repo):

```bash
pip install -r requirements.txt
```

Main pinned packages include:
- `numpy==1.26.4`
- `opencv-python-headless==4.10.0.84`
- `setuptools==68.2.2`

## 2) Dataset Setup

### Expected dataset locations

The training YAML files point to these absolute paths:

- `yolov5/data/StudentWatch.yaml` -> `/workspace/dl_project/project_yolov5/dataset/yolov5/sb`
- `yolov5/data/StudentWatch_no_hr.yaml` -> `/workspace/dl_project/project_yolov5/dataset/yolov5/sb_no_hr`

Expected structure:

```text
dataset/yolov5/
  sb/
    train/images, train/labels
    valid/images, valid/labels
    test/images,  test/labels
  sb_no_hr/
    train/images, train/labels
    valid/images, valid/labels
    test/images,  test/labels
```

### Current split sizes (for sanity check)

- `train`: 235 images / 235 labels
- `valid`: 67 images / 67 labels
- `test`: 33 images / 33 labels

for both `sb` and `sb_no_hr`.

### If you only have the original dataset zip

A zip exists at:

```text
dataset/yolov5/SCB-U-.v1i.yolov5pytorch.zip
```

Unzip it to create `sb` first, then build `sb_no_hr` by removing class `hand_raising` with remapped labels:

```bash
cd /workspace/dl_project/project_yolov5
python dataset/yolov5/cp.py
```

## 3) Class Definitions

### Full dataset (`StudentWatch.yaml`)
6 classes:
- `0: bowing_the_head`
- `1: hand_raising`
- `2: learning_over_the_table`
- `3: reading`
- `4: using_phone`
- `5: writing`

### No-HR dataset (`StudentWatch_no_hr.yaml`)
5 classes (hand_raising removed):
- `0: bowing_the_head`
- `1: learning_over_the_table`
- `2: reading`
- `3: using_phone`
- `4: writing`

## 4) Code Structure

Key files/folders:

- `yolov5/train.py`: standard training entry
- `yolov5/train_weighted_loss.py`: weighted-loss training entry
- `yolov5/utils/weighted_loss.py`: weighted classification loss implementation
- `yolov5/models/yolov5s.yaml`: baseline architecture
- `yolov5/models/yolov5s_se*.yaml`: SE variants
- `yolov5/data/StudentWatch*.yaml`: dataset configs
- `yolov5/data/hyps/hyp.sb_aug.yaml`: augmentation hyperparameters
- `yolov5/shell_run/*.sh`: original experiment scripts
- `yolov5/shell_run/01_* ... 05_*`: categorized wrappers
- `yolov5/logs/*.log`: log outputs from batch scripts
- `yolov5/runs/train/<exp_name>/`: training outputs and checkpoints

## 5) Model Variants and SE Placement

- `models/yolov5s.yaml`: baseline YOLOv5s
- `models/yolov5s_se.yaml`: SE after backbone P4 C3 and P5 C3
- `models/yolov5s_se_p4.yaml`: SE only after backbone P4 C3
- `models/yolov5s_se_p5.yaml`: SE only after backbone P5 C3
- `models/yolov5s_se_p3_p4_p5.yaml`: SE after backbone P3, P4, and P5 C3
- `models/yolov5s_se_head_p4.yaml`: SE after head P4 fusion block
- `models/yolov5s_se_head_p4_p5.yaml`: SE after head P4 and head P5 fusion blocks

SE module is implemented in `models/common.py` as class `SE`.

## 6) 🚀 How to Run Experiments

## 📂 Step 1: Go to Project Directory

```bash
cd /home/xinyic/dl_project/project_yolov5/yolov5
```

(Use `/workspace/dl_project/project_yolov5/yolov5` in this environment.)

### 🔹 Baseline

```bash
bash shell_run/run_sb.sh
```

### 🔹 Drop Hand-Raising Class

```bash
bash shell_run/run_sb_no_hr.sh
```

### 🔹 Drop HR + Data Augmentation

```bash
bash shell_run/run_sb_no_hr_aug.sh
```

### 🔹 Drop HR + Weighted Loss

```bash
bash shell_run/run_sb_no_hr_weighted.sh
```

### 🔹 Drop HR + Aug + Weighted Loss

```bash
bash shell_run/run_sb_no_hr_aug_weighted.sh
```

### 🔹 SE + Drop HR

```bash
bash shell_run/run_se_NOhr.sh
```

### 🔹 SE + Drop HR + Data Augmentation

```bash
bash shell_run/run_se_NOhr_aug.sh
```

### 🔹 SE + Drop HR + Weighted Loss

```bash
bash shell_run/run_se_NOhr_weighted.sh
```

### 🔹 SE + Drop HR + Aug + Weighted Loss

```bash
bash shell_run/run_se_NOhr_aug_weighted.sh
```

### 🔹 SE Position Ablation Runs

```bash
bash shell_run/run_sb_se_p4.sh
bash shell_run/run_sb_se_p5.sh
bash shell_run/run_sb_se_p3_p4_p5.sh
bash shell_run/run_sb_se_head_p4.sh
bash shell_run/run_sb_se_head_p4_p5.sh
```

### 🔹 Follow-up: Best SE Placement + Weighted Loss

```bash
bash shell_run/run_sb_se_p3_p4_p5_weighted.sh
```

## 7) Batch Run Options

Run all non-SE imbalance experiments:

```bash
bash shell_run/runall.sh
```

Run all SE imbalance experiments:

```bash
bash shell_run/runall_se.sh
```

Run all SE ablation experiments:

```bash
bash shell_run/run_all_se_ablation.sh
```

Run categorized experiment groups:

```bash
bash shell_run/run_all_by_category.sh
```

## 8) Experiment-to-Config Map

- `run_sb.sh` -> `train.py`, `data/StudentWatch.yaml`, `models/yolov5s.yaml`
- `run_sb_no_hr.sh` -> `train.py`, `data/StudentWatch_no_hr.yaml`, `models/yolov5s.yaml`
- `run_sb_no_hr_aug.sh` -> `train.py`, `data/StudentWatch_no_hr.yaml`, `models/yolov5s.yaml`, `--hyp data/hyps/hyp.sb_aug.yaml`
- `run_sb_no_hr_weighted.sh` -> `train_weighted_loss.py`, `data/StudentWatch_no_hr.yaml`, `models/yolov5s.yaml`
- `run_sb_no_hr_aug_weighted.sh` -> `train_weighted_loss.py`, `data/StudentWatch_no_hr.yaml`, `models/yolov5s.yaml`, `--hyp data/hyps/hyp.sb_aug.yaml`
- `run_se_NOhr.sh` -> `train.py`, `data/StudentWatch_no_hr.yaml`, `models/yolov5s_se.yaml`
- `run_se_NOhr_aug.sh` -> `train.py`, `data/StudentWatch_no_hr.yaml`, `models/yolov5s_se.yaml`, `--hyp data/hyps/hyp.sb_aug.yaml`
- `run_se_NOhr_weighted.sh` -> `train_weighted_loss.py`, `data/StudentWatch_no_hr.yaml`, `models/yolov5s_se.yaml`
- `run_se_NOhr_aug_weighted.sh` -> `train_weighted_loss.py`, `data/StudentWatch_no_hr.yaml`, `models/yolov5s_se.yaml`, `--hyp data/hyps/hyp.sb_aug.yaml`
- `run_sb_se_p4.sh` -> `train.py`, `data/StudentWatch_no_hr.yaml`, `models/yolov5s_se_p4.yaml`
- `run_sb_se_p5.sh` -> `train.py`, `data/StudentWatch_no_hr.yaml`, `models/yolov5s_se_p5.yaml`
- `run_sb_se_p3_p4_p5.sh` -> `train.py`, `data/StudentWatch_no_hr.yaml`, `models/yolov5s_se_p3_p4_p5.yaml`
- `run_sb_se_head_p4.sh` -> `train.py`, `data/StudentWatch_no_hr.yaml`, `models/yolov5s_se_head_p4.yaml`
- `run_sb_se_head_p4_p5.sh` -> `train.py`, `data/StudentWatch_no_hr.yaml`, `models/yolov5s_se_head_p4_p5.yaml`
- `run_sb_se_p3_p4_p5_weighted.sh` -> `train_weighted_loss.py`, `data/StudentWatch_no_hr.yaml`, `models/yolov5s_se_p3_p4_p5.yaml`

## 9) What Each Script Actually Uses

All scripts use:
- image size `640`
- batch size `2`
- epochs `1000`
- pretrained weights `yolov5s.pt`
- `--cache`
- `--workers 2`
- `--patience 0` (effectively no early stopping)

Differences:
- Augmentation experiments add `--hyp data/hyps/hyp.sb_aug.yaml`
- Weighted experiments use `train_weighted_loss.py`
- SE experiments switch `--cfg` to a SE model YAML

## 10) Reproducibility Notes

- Weighted classification loss is hardcoded in `utils/weighted_loss.py` with class counts:
  `class_counts = [94, 99, 782, 631, 329]`.
- If your `sb_no_hr` label distribution changes, update those values for fair weighting.
- Use `yolov5/data/StudentWatch_no_hr.yaml` for training. The dataset-local file `dataset/yolov5/sb_no_hr/data.yaml` still shows 6 classes and is not the training entry used by scripts.
- `shell_run/run_sb_no_hr_aug_weighted.sh` includes `--patience 30` and later `--patience 0`; the last one (`0`) is the effective value.
- Logs are written to `yolov5/logs/*.log` when using the batch scripts.
- Checkpoints are under `yolov5/runs/train/<experiment_name>/weights/{best,last}.pt`.

## 11) Quick Validation (Optional)

After training, evaluate a checkpoint:

```bash
python val.py \
  --weights runs/train/sb_baseline/weights/best.pt \
  --data data/StudentWatch.yaml \
  --img 640
```

For no-HR experiments, change `--data` to `data/StudentWatch_no_hr.yaml`.
