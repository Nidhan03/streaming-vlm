#!/bin/bash

echo "========================================="
echo "StreamingVLM Training Environment Check"
echo "========================================="
echo ""

# Activate environment
source $HOME/miniconda/etc/profile.d/conda.sh
conda activate streamingvlm-train

# Check Python version
echo "✓ Checking Python version..."
python_version=$(python --version 2>&1)
echo "  $python_version"
echo ""

# Check CUDA availability
echo "✓ Checking CUDA availability..."
python -c "import torch; print(f'  PyTorch version: {torch.__version__}'); print(f'  CUDA available: {torch.cuda.is_available()}'); print(f'  CUDA version: {torch.version.cuda if torch.cuda.is_available() else \"N/A\"}'); print(f'  Number of GPUs: {torch.cuda.device_count()}')"
echo ""

# Check critical packages
echo "✓ Checking critical packages..."
packages=(
    "transformers"
    "accelerate"
    "peft"
    "deepspeed"
    "flash_attn"
    "liger_kernel"
    "datasets"
    "tensorboard"
    "wandb"
    "gradio"
    "qwen_vl_utils"
)

for pkg in "${packages[@]}"; do
    python -c "import importlib; importlib.import_module('${pkg//-/_}'); print('  ✓ ${pkg}')" 2>/dev/null || echo "  ✗ ${pkg} - MISSING"
done
echo ""

# Check GPU memory
echo "✓ Checking GPU memory..."
python -c "import torch; [print(f'  GPU {i}: {torch.cuda.get_device_properties(i).name} - {torch.cuda.get_device_properties(i).total_memory / 1024**3:.2f} GB') for i in range(torch.cuda.device_count())]" 2>/dev/null || echo "  No GPUs detected"
echo ""

# Check DeepSpeed
echo "✓ Checking DeepSpeed configuration..."
python -c "import deepspeed; print(f'  DeepSpeed version: {deepspeed.__version__}')" 2>/dev/null || echo "  DeepSpeed check failed"
echo ""

# Check Flash Attention
echo "✓ Checking Flash Attention..."
python -c "import flash_attn; print(f'  Flash Attention version: {flash_attn.__version__}')" 2>/dev/null || echo "  Flash Attention check failed"
echo ""

echo "========================================="
echo "Environment verification complete!"
echo "========================================="
