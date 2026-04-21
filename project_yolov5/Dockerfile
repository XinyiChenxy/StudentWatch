FROM pytorch/pytorch:2.1.0-cuda11.8-cudnn8-runtime

WORKDIR /workspace

RUN pip install --upgrade pip

# COPY yolov5 /workspace/yolov5

WORKDIR /workspace/yolov5

ENV YOLOv5_AUTOINSTALL=False
ENV YOLO_CONFIG_DIR=/tmp/Ultralytics

RUN pip uninstall -y numpy opencv-python opencv-python-headless setuptools || true

RUN pip install --no-cache-dir \
    numpy==1.26.4 \
    setuptools==68.2.2 \
    opencv-python-headless==4.10.0.84 \
    matplotlib \
    pandas \
    seaborn \
    tqdm \
    pillow \
    pyyaml \
    requests \
    scipy \
    tensorboard

RUN pip install --no-cache-dir -r requirements.txt

RUN pip uninstall -y numpy opencv-python opencv-python-headless setuptools || true && \
    pip install --no-cache-dir \
    numpy==1.26.4 \
    setuptools==68.2.2 \
    opencv-python-headless==4.10.0.84

CMD ["bash"]