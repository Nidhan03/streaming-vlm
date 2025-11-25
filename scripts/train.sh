#!/bin/bash

# Activate environment
eval "$(conda shell.bash hook)"
conda activate streamingvlm-train

echo "Starting training..."
echo ""

python train.py "$@"

echo ""
echo "Training completed!"
