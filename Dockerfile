# syntax=docker/dockerfile:1

# 指定基底镜像
FROM python:3.9-slim-buster

# 镜像中的工作目录
WORKDIR /app

# 複製所有內容到工作目錄下(除了原始影像與特徵，因為太大)
RUN mkdir bin
COPY bin/test-object-detector.py bin/

RUN mkdir -p data/config
COPY data/config/config.cfg data/config/

RUN mkdir -p data/features/
RUN mkdir -p data/images/pos data/images/neg
RUN mkdir -p data/models

# 複製測試用影像
COPY data/images/neg/1E2A2127-3CF8-44E9-ACD2-1C9BB16CA0D5.JPG data/images/neg/
COPY data/images/pos/00001_1.jpg data/images/pos/

RUN mkdir -p object-detector
COPY object-detector/__init__.py object-detector/
COPY object-detector/config.py object-detector/
COPY object-detector/extract_features.py object-detector/
COPY object-detector/nms.py object-detector/
COPY object-detector/test_classifier.py object-detector/
COPY object-detector/train_classifier.py object-detector/

# 给开发环境安装所需套件
COPY requirements.txt requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt -i https://mirrors.ustc.edu.cn/pypi/web/simple/