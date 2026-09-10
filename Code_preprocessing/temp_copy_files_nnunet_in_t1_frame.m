%Prepare the FLAIR and T1 files for nnUNet segmentation
%Questions and comments chen.yasheng@gmail.com

function temp_copy_files_nnunet(dir_root, sign_2d3d)

addpath('./NIFTI_yasheng');

dir_t1  = sprintf('%s/T1', dir_root);
dir_fl  = sprintf('%s/%s_FLAIR_to_T1',        dir_root, upper(sign_2d3d));
dir_out = sprintf('%s/%s_FLAIR_nnunet_input', dir_root, upper(sign_2d3d));

mkdir(dir_out);
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
names_t1 = sprintf('%s/*_t1_vox1_brain_restore_normalized.nii.gz', dir_t1);
names_t1 = dir(names_t1);
nums = length(names_t1);

for i=1:nums,
   
   nnn = strrep(names_t1(i).name, '_t1_vox1_brain_restore_normalized.nii.gz', '');
   name1 = sprintf('%s/%s', dir_t1, names_t1(i).name);

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
   if strcmp(sign_2d3d, '2d') == 1
      name0      = sprintf('%s/%s_flair_vox1_brain_restore_normalized.nii.gz',    dir_fl, nnn);

      name0_out  = sprintf('%s/%s_0000.nii.gz',  dir_out, nnn);
      name1_out  = sprintf('%s/%s_0001.nii.gz',  dir_out, nnn);
   else
      name0      = sprintf('%s/%s_3d_flair_vox1_brain_restore_normalized.nii.gz', dir_fl, nnn);

      name0_out  = sprintf('%s/%s_3d_0000.nii.gz',  dir_out, nnn);
      name1_out  = sprintf('%s/%s_3d_0001.nii.gz',  dir_out, nnn);
   end;
   
   if ~exist(name1) | ~exist(name0)
      continue;
   end;
      
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
   cp1 = sprintf('cp %s %s', name0, name0_out); disp(cp1); system(cp1);
   cp2 = sprintf('cp %s %s', name1, name1_out); disp(cp2); system(cp2); 
   
   fprintf('\n');
   
   clear nnn name1 name0 name0_out name1_out;
end;
   
