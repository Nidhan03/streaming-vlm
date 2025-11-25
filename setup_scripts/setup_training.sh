#!/bin/bash

echo "Creating StreamingVLM Training Environment..."
echo ""

echo "Installing Miniconda..."
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p $HOME/miniconda
rm miniconda.sh
export PATH="$HOME/miniconda/bin:$PATH" #conda commands are found first
source $HOME/miniconda/etc/profile.d/conda.sh #initialize conda for bash

echo "Creating conda environment..."
conda create -n streamingvlm-train python=3.11 -y
conda activate streamingvlm-train

echo "Installing system dependencies..."
conda install -y ffmpeg

echo "Installing PyTorch..."
pip install torch==2.7.1 torchvision==0.22.1 torchaudio==2.7.1

echo "Installing training requirements..."
pip install -r sft_requirements.txt

echo "Installing DeepSpeed..."
pip install deepspeed==0.17.1

echo "Installing Flash Attention..."
pip install flash-attn==2.8.0.post2 --no-build-isolation

echo "Installing local package..."
pip install -e streaming_vlm/livecc_utils/

echo ""
echo "✅ Training environment setup complete!"
echo "Activate with: conda activate streamingvlm-train"
