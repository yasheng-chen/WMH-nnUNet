%The driving program for FLAIR to T1 registration
%Questions and comments chen.yasheng@gmail.com

num_parpool = 16;

addpath('./NIFTI_yasheng');

dir_root = '../ADNI';
%dir_root = '../ADRC';

name_dir_flair_2d = sprintf('%s/2D_FLAIR', dir_root); 
name_dir_flair_3d = sprintf('%s/3D_FLAIR', dir_root); 
name_dir_t1       = sprintf('%s/T1', dir_root);; 

name_dir_reg_2d   = sprintf('%s/2D_FLAIR_to_T1', dir_root);
name_dir_reg_3d   = sprintf('%s/3D_FLAIR_to_T1', dir_root);

mkdir(name_dir_reg_2d);
mkdir(name_dir_reg_3d);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
names_all = sprintf('%s/*_t1.nii.gz', name_dir_t1);
names_all = dir(names_all);
nums_all = length(names_all);

name_tobe_flair = {};
name_tobe_t1    = {};
name_tobe_mat   = {};
name_tobe_out   = {};

name_tobe_fmask      = {};
name_tobe_fmask_out  = {};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

index=1;

for i=1:nums_all,

   nnn = strrep(names_all(i).name, '_t1.nii.gz', '');

   name_t1 = sprintf('%s/%s_t1_vox1_brain_restore.nii.gz', name_dir_t1, nnn);   
   name_flair_2d = sprintf('%s/%s_flair_vox1_brain_restore.nii.gz',    name_dir_flair_2d, nnn);
   name_flair_3d = sprintf('%s/%s_3d_flair_vox1_brain_restore.nii.gz', name_dir_flair_3d, nnn);
 
   name_fmask_2d = strrep(name_flair_2d, '_restore.nii.gz', '_mask.nii.gz');
   name_fmask_3d = strrep(name_flair_3d, '_restore.nii.gz', '_mask.nii.gz');

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
   name_mat_2d = sprintf('%s/%s_flair2t1.mat',    name_dir_reg_2d, nnn);
   name_mat_3d = sprintf('%s/%s_3d_flair2t1.mat', name_dir_reg_3d, nnn);

   name_out_2d = sprintf('%s/%s_flair_vox1_brain_restore.nii.gz',    name_dir_reg_2d, nnn);
   name_out_3d = sprintf('%s/%s_3d_flair_vox1_brain_restore.nii.gz', name_dir_reg_3d, nnn);

   name_out_mask_2d = strrep(name_out_2d, '_restore.nii.gz', '_mask.nii.gz');
   name_out_mask_3d = strrep(name_out_3d, '_restore.nii.gz', '_mask.nii.gz');
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
   if ~exist(name_t1)
      continue;
   end;
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   if exist(name_flair_2d) & ~exist(name_mat_2d)
      name_tobe_flair{index} = name_flair_2d;
      name_tobe_t1{index}    = name_t1;
      name_tobe_mat{index}   = name_mat_2d;
      name_tobe_out{index}   = name_out_2d;

      name_tobe_fmask{index}     = name_fmask_2d;
      name_tobe_fmask_out{index} = name_out_mask_2d;
      
      index=index+1;
   end;

   if exist(name_flair_3d) & ~exist(name_mat_3d)
      name_tobe_flair{index} = name_flair_3d;
      name_tobe_t1{index}    = name_t1;
      name_tobe_mat{index}   = name_mat_3d;
      name_tobe_out{index}   = name_out_3d;

      name_tobe_fmask{index}     = name_fmask_3d;
      name_tobe_fmask_out{index} = name_out_mask_3d;

      index=index+1;
   end;
   
   clear nnn name_t1 name_flair_2d name_flair_3d name_mat_2d name_mat_3d;
   clear name_out_2d name_out_3d;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

poolobj = parpool(num_parpool);

parfor i = 1:length(name_tobe_flair),
   reg_flirt_parallel(name_tobe_flair{i}, name_tobe_t1{i}, name_tobe_mat{i}, name_tobe_out{i});
end;

delete(poolobj);

for i=1:length(name_tobe_flair)
   flirt = sprintf('flirt -in %s -ref %s -out %s -applyxfm -init %s -interp nearestneighbour', name_tobe_fmask{i}, name_tobe_t1{i}, name_tobe_fmask_out{i}, name_tobe_mat{i});
   disp(flirt);
   system(flirt);
end;




