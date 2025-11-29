#!/bin/bash


echo "Creating StreamingVLM Inference Environment..."
cd ../..
echo ""

echo "Installing Miniconda..."
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p $HOME/miniconda
rm miniconda.sh
export PATH="$HOME/miniconda/bin:$PATH" #conda commands are found first
source $HOME/miniconda/etc/profile.d/conda.sh #initialize conda for bash

conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

echo "Creating conda environment..."
conda create -n streamingvlm-infer python=3.11 -y
conda activate streamingvlm-infer

pip install --upgrade pip

cd streaming-vlm

echo "Installing system dependencies..."
conda install -y ffmpeg

echo "Installing PyTorch..."
pip install torch==2.7.1 torchvision==0.22.1 torchaudio

echo "Installing inference requirements..."
pip install -r infer_requirements.txt

echo "Installing local package..."
pip install -e streaming_vlm/livecc_utils/

echo ""
echo "✅ Inference environment setup complete!"
