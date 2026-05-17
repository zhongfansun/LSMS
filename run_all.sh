#!/bin/bash
set -eo pipefail
BASE_PATH=$(pwd)
echo "Current Path: $BASE_PATH"

gpu_id=7
cp $BASE_PATH/modeling_llava/modeling_llava.py /usr/local/lib/python3.10/dist-packages/transformers/models/llava/modeling_llava.py

TARGET_PATH="$BASE_PATH/output/llava1_5-13b-instruct"
echo "Target Path: $TARGET_PATH"

CUDA_VISIBLE_DEVICES=$gpu_id \
swift sft --model_type llava1_5-13b-instruct \
--dataset okvqa_anstraining_train_dataset.csv --val_dataset okvqa_anstraining_val_dataset.csv \
--num_train_epochs 2 --save_strategy epoch --evaluation_strategy epoch \
--per_device_train_batch_size 4 \
--target_modules '^(mcan_net.backbone)(?!.*(proj1|proj|lm_head|output|emb|wte|shared)).*' \
--modules_to_save VQA_features_mapping.0 VQA_features_mapping.1 mcan_private_vision large_private_vision


NEWEST_DIR=$(find -L "$TARGET_PATH" -mindepth 1 -maxdepth 1 -type d -printf "%T@ %p\n" 2>/dev/null | sort -nr | head -n 1 | awk '{print $2}')


CUDA_VISIBLE_DEVICES=$gpu_id swift export --ckpt_dir "$NEWEST_DIR/checkpoint-563" --merge_lora true

CUDA_VISIBLE_DEVICES=$gpu_id swift infer --ckpt_dir "$NEWEST_DIR/checkpoint-563-merged" --load_dataset_config true







