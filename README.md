# StudentWatch YOLO Experiments

This repository contains experimental code for evaluating YOLO-based object detection models on the StudentWatch dataset. The project is organized as a unified workspace with separate sub-projects for baseline experiments, attention-module comparisons, and extended future comparisons.

## Experimental Setup

The experiments in this study are conducted based on a unified repository designed for systematic evaluation of YOLOv5-based models and their variants on the StudentWatch dataset. The repository is organized into three main sub-projects, each corresponding to a different experimental focus.

## Repository Structure

```text
/workspace/dl_project
├── project_yolov5/          # Main YOLOv5 baseline and SE experiments
│   ├── Dockerfile           # Unified YOLOv5 environment
│   ├── README.md            # Detailed instructions for this module
│   └── yolov5/              # Training scripts, model configs, and experiment settings
├── SE_CBAM/                 # SE and CBAM attention comparison experiments
│   ├── README.md            # Detailed instructions for this module
│   └── yolov5_CBAM/         # Training scripts and configurations
└── YOLO26/                  # Extended experiments for future comparison
    ├── Dockerfile           # Environment for yolo26 experiments
    └── README.md            # Detailed instructions for this module
```

## Sub-projects

### project_yolov5

`project_yolov5` contains the primary YOLOv5-based experimental pipeline. It includes:

- YOLOv5 baseline experiments
- YOLOv5 with SE (Squeeze-and-Excitation) modules
- Data imbalance handling strategies, including removing the `hand_raising` class, weighted loss, and data augmentation
- SE placement ablation experiments 

See `project_yolov5/README.md` for detailed environment setup, dataset preparation, training commands, and experiment descriptions.

### SE_CBAM

`SE_CBAM` is designed for CBAM. It includes:


- YOLOv5 + CBAM (Convolutional Block Attention Module)

This module uses the same YOLOv5-based environment as `project_yolov5`. See `SE_CBAM/README.md` for detailed instructions, configurations, and reproducibility notes.

### YOLO26

`YOLO26` is reserved for extended experiments and future comparison. Unlike the YOLOv5-based modules, it provides its own Dockerfile and environment setup. See `YOLO26/README.md` for details when working with this module.

## Environment Notes

The YOLOv5-based modules, including `project_yolov5` and `SE_CBAM`, use the same experimental environment. The reference Dockerfile is provided in:

```text
project_yolov5/Dockerfile
```

The `YOLO26` module provides its own Dockerfile because it uses a separate environment.

## Documentation

Each sub-project provides its own README with detailed usage instructions:

- `project_yolov5/README.md`
- `SE_CBAM/README.md`
- `YOLO26/README.md`

Please refer to the corresponding README before running experiments in each module.
