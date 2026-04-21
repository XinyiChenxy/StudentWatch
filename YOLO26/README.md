# Student Behavior Detection - YOLO26

A deep learning-based system for detecting and monitoring student behavior in educational settings using YOLO26 architecture.

## Overview

This project uses the YOLOv26 object detection model to identify and track various student behaviors in classroom environments. The system is containerized with Docker for easy deployment and training.

## Prerequisites

- Docker Desktop (with GPU support for NVIDIA GPUs)
- Python 3.10 (for local development)
- CUDA 13.0 and cuDNN 9 (automatically included in Docker image)

## Quick Start

### Building the Docker Image

Build the Docker image with the following command:

```bash
docker build -t student-behavior-detector .
```

This command:
- Pulls the PyTorch 2.11.0 CUDA 13.0 base image
- Installs required system dependencies
- Installs Python dependencies from `requirements.txt`
- Prepares the training script

## Running the Web Service

To start the web interface for inference:

```bash
docker run -p 8000:8000 student-behavior-detector
```

This command:
- Maps port 8000 from the container to your host machine
- Starts the Flask/FastAPI web service

Once running, open your browser and navigate to:

```
http://localhost:8000
```

You can then:
- Upload images or videos for detection
- View real-time inference results
- Monitor detected student behaviors

## Training the Model

To train or fine-tune the model with GPU support:

```bash
docker run -it --rm --gpus all student-behavior-detector bash
```

This command:
- `-it`: Allocates an interactive terminal
- `--rm`: Automatically removes the container after exit
- `--gpus all`: Gives the container access to all available NVIDIA GPUs

Once inside the container, run the training script:

```bash
python train_yolo26.py
```

The training script will:
- Load the dataset from `sb_no_hr/` directory
- Train the YOLO26 model
- Save the best weights to `model/yolo26s_best.pt`
- Generate training metrics and visualizations in the `runs/` directory

### Training Configuration

Edit `StudentWatch_no_hr.yaml` to configure:
- Dataset paths
- Model architecture
- Training hyperparameters
- Batch size and learning rate

## Project Structure

```
.
├── app.py                                                                # Web application
├── train_yolo26.py                                                       # Training script
├── requirements.txt                                                      # Python dependencies
├── Dockerfile                                                            # Docker configuration
├── StudentWatch_no_hr.yaml                                               # Dataset and training config
├── index.html                                                            # Web UI
├── model/                                                                # Pre-trained and trained weights
│   └── yolo26s_best.pt                                                   # Best model weights
└── sb_no_hr/ (Please put the dataset into this structure)                # Dataset directory
    ├── train/                                                            # Training images and labels
    ├── valid/                                                            # Validation images and labels
    └── test/                                                             # Test images and labels
```

## Local Development (Without Docker)

To set up a local development environment:

1. Create a virtual environment:
   ```bash
   python -m venv .venv
   .venv\Scripts\activate  # On Windows
   source .venv/bin/activate  # On macOS/Linux
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Run the web service:
   ```bash
   python app.py
   ```

4. Run training:
   ```bash
   python train_yolo26.py
   ```

## Model Details

- **Architecture**: YOLO26 (yolo26s variant)
- **Input**: Images of classroom environments
- **Output**: Bounding boxes with behavior class predictions
- **Behavior Classes**: Configured in `StudentWatch_no_hr.yaml`

## Support and Troubleshooting

- **GPU not detected in Docker**: Ensure you have Docker Desktop with GPU support enabled
- **Out of memory errors**: Reduce batch size in `StudentWatch_no_hr.yaml`
- **Missing dataset**: Ensure that `sb_no_hr/` is in the directory and contains train/valid/test splits with images and labels