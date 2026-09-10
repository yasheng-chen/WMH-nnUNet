
These programs are developed by Dr. Yasheng Chen, Dr. Chia-Ling Phuah, Byron Xu, and Dr.Uttam Khatri as part of the preprocessing pipeline for FLAIR WMH segmentation.
Please email chen.yasheng@gmail.com and cphuah@Barrowneuro.org for questions and comments.
09/04/2026

1. Please store the files in the following structures:
    ADNI/T1/Original/subject_name_t1.nii.gz
    ADNI/2D_FLAIR/Original/subject_name_flair.nii.gz
    ADNI/3D_FLAIR/Original/subject_name_3d_flair.nii.gz
2. temp_cal_t1.m to preprocess the T1 images
3. temp_cal_flair.m to preprocess the FLAIR images (both 2D and 3D)
4. temp_reg_flair2t1.m to register the FLAIR images to T1
5. temp_normalize_in_t1_frame.m to normalize the registered FLAIR and T1 images
6. temp_copy_files_nnunet_in_t1_frame.m to prepare the preprocessed FLAIR and T1 for nnUNet WMH segmentation

This preprocessing pipeline has been designed with minimal user intervention needed. If the files are organized as suggested, the only input needed is the directory of the input NIFTI files.

