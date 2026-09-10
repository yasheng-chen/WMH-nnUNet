#!/bin/bash

gpu_id=$1
input_folder=$2
output_folder=$3
model_folder=./Dataset001_wmh_2d3d_flairt1

export TORCHDYNAMO_DISABLE=1

CUDA_VISIBLE_DEVICES=$1 nnUNetv2_predict_from_modelfolder -i $input_folder -o $output_folder -m $model_folder -f 0 -tr nnUNetTrainerDA5 -c 3d_fullres -p nnUNetPlans -chk checkpoint_best.pth

