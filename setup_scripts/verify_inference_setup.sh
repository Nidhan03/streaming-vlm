#!/bin/bash

echo "========================================="
echo "StreamingVLM Inference Environment Check"
echo "========================================="
echo ""

# Activate environment
source $HOME/miniconda/etc/profile.d/conda.sh
conda activate streamingvlm-infer

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
    "decord"
    "opencv-python"
    "qwen_vl_utils"
    "flash_attn"
    "liger_kernel"
    "numpy"
)

for pkg in "${packages[@]}"; do
    python -c "import importlib; importlib.import_module('${pkg//-/_}'); print('  ✓ ${pkg}')" 2>/dev/null || echo "  ✗ ${pkg} - MISSING"
done
echo ""

# Check GPU memory
echo "✓ Checking GPU memory..."
python -c "import torch; [print(f'  GPU {i}: {torch.cuda.get_device_properties(i).name} - {torch.cuda.get_device_properties(i).total_memory / 1024**3:.2f} GB') for i in range(torch.cuda.device_count())]" 2>/dev/null || echo "  No GPUs detected"
echo ""

echo "========================================="
echo "Environment verification complete!"
echo "========================================="
