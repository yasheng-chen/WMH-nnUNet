%The driving program for T1 preprocessing
%Questions and comments chen.yasheng@gmail.com
	
addpath('./NIFTI_yasheng');

name_dir = '../ADNI/T1';
%name_dir = '../ADRC/T1';

names_all = sprintf('%s/Original/*_t1.nii.gz', name_dir);
names_all = dir(names_all);
nums_all = length(names_all);

for i=1:nums_all,
   nnn = strrep(names_all(i).name, '_t1.nii.gz', '');
   name_in  = sprintf('%s/Original/%s_t1.nii.gz', name_dir, nnn);
   name_out = sprintf('%s/%s_t1.nii.gz',          name_dir, nnn);

   fsl = sprintf('fslreorient2std %s %s', name_in, name_out);
   disp(fsl);
   system(fsl);

   revise_intercept_slope(name_out, name_out);
   
   clear nnn name_in name_out fsl;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:nums_all,

   nnn = strrep(names_all(i).name, '_t1.nii.gz', '');
   name_t1 = sprintf('%s/%s_t1.nii.gz', name_dir, nnn);
   name_vox1 = strrep(name_t1,'.nii.gz', '_vox1.nii.gz');

   %%%%%%%%%%%%%%%%%%%%%
   flirt = sprintf('flirt -in %s -ref %s -applyisoxfm 1 -out %s', name_t1, name_t1, name_vox1);
   disp(flirt);
   system(flirt);

   resize_image_fsl_center(name_vox1, name_vox1, 256, 256, 256);
   
   clear nnn name_t1 name_vox1;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:nums_all,
   nnn = strrep(names_all(i).name, '_t1.nii.gz', '');
   
   name_t1      = sprintf('%s/%s_t1_vox1.nii.gz',               name_dir, nnn);
   name_brain   = sprintf('%s/%s_t1_vox1_brain.nii.gz',         name_dir, nnn);
   name_mask    = sprintf('%s/%s_t1_vox1_brain_mask.nii.gz',    name_dir, nnn);
   name_restore = sprintf('%s/%s_t1_vox1_brain_restore.nii.gz', name_dir, nnn);
   
   skullstrip = sprintf('mri_synthstrip -i %s -o %s -m %s', name_t1, name_brain, name_mask);
   disp(skullstrip);
   system(skullstrip);
      
   n4 = sprintf('N4BiasFieldCorrection -i %s -x %s -o %s', name_brain, name_mask, name_restore);
   disp(n4);
   system(n4);
end;


