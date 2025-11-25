#!/bin/bash

# ============================================================
# Custom Configuration Variables
# ============================================================
MODEL_PATH="mit-han-lab/StreamingVLM"
VIDEO_PATH="sample_videos/demo.mp4"
OUTPUT_DIR="output/inference_result.vtt"
QUERY="Correct the exercise"
WINDOW_SIZE="16"
CHUNK_DURATION="1"
TEXT_ROUND="16"
TEMPERATURE="0.9"
DURATION="6000"

# ============================================================
# Activate environment
# ============================================================
eval "$(conda shell.bash hook)"
conda activate streamingvlm-infer

echo "============================================================"
echo "StreamingVLM Inference"
echo "============================================================"
echo "Model Path:       $MODEL_PATH"
echo "Video Path:       $VIDEO_PATH"
echo "Output Dir:       $OUTPUT_DIR"
echo "Query:            $QUERY"
echo "Window Size:      $WINDOW_SIZE"
echo "Chunk Duration:   $CHUNK_DURATION"
echo "Text Round:       $TEXT_ROUND"
echo "Temperature:      $TEMPERATURE"
echo "Duration:         $DURATION"
echo "============================================================"
echo ""

# Create output directory if it doesn't exist
mkdir -p "$(dirname "$OUTPUT_DIR")"

# Run inference with custom variables or command-line arguments
python streaming_vlm/inference/inference.py \
    --model_path "$MODEL_PATH" \
    --video_path "$VIDEO_PATH" \
    --output_dir "$OUTPUT_DIR" \
    --query "$QUERY" \
    --window_size "$WINDOW_SIZE" \
    --chunk_duration "$CHUNK_DURATION" \
    --text_round "$TEXT_ROUND" \
    --temperature "$TEMPERATURE" \
    --duration "$DURATION" \
    "$@"

echo ""
echo "============================================================"
echo "Inference completed!"
echo "Results saved to: $OUTPUT_DIR"
echo "============================================================"
