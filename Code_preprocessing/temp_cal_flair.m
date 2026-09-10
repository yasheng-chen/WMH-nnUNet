%The driving program for FLAIR preprocessing
%Questions and comments chen.yasheng@gmail.com

addpath('./NIFTI_yasheng');

name_dir = '../ADNI/2D_FLAIR';
%name_dir = '../ADNI/3D_FLAIR';

%name_dir = '../ADRC/2D_FLAIR';
%name_dir = '../ADRC/3D_FLAIR';

names_all = sprintf('%s/Original/*_flair.nii.gz', name_dir);
names_all = dir(names_all);
nums_all = length(names_all);

for i=1:nums_all,
   nnn = strrep(names_all(i).name, '_flair.nii.gz', '');
   name_in  = sprintf('%s/Original/%s_flair.nii.gz', name_dir, nnn);
   name_out = sprintf('%s/%s_flair.nii.gz',          name_dir, nnn);

   fsl = sprintf('fslreorient2std %s %s', name_in, name_out);
   disp(fsl);
   system(fsl);
   
   revise_intercept_slope(name_out, name_out);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:nums_all,

   nnn = strrep(names_all(i).name, '_flair.nii.gz', '');
   name_flair = sprintf('%s/%s_flair.nii.gz', name_dir, nnn);
   name_vox1 = strrep(name_flair,'.nii.gz', '_vox1.nii.gz');

   %%%%%%%%%%%%%%%%%%%%%
   flirt = sprintf('flirt -in %s -ref %s -applyisoxfm 1 -out %s', name_flair, name_flair, name_vox1);
   disp(flirt);
   system(flirt);
      
   clear nnn name_flair name_vox1 flirt;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:nums_all,
   nnn = strrep(names_all(i).name, '_flair.nii.gz', '');
   
   name_flair   = sprintf('%s/%s_flair_vox1.nii.gz',               name_dir, nnn);
   name_brain   = sprintf('%s/%s_flair_vox1_brain.nii.gz',         name_dir, nnn);
   name_mask    = sprintf('%s/%s_flair_vox1_brain_mask.nii.gz',    name_dir, nnn);
   name_restore = sprintf('%s/%s_flair_vox1_brain_restore.nii.gz', name_dir, nnn);
   
   skullstrip = sprintf('mri_synthstrip -i %s -o %s -m %s', name_flair, name_brain, name_mask);
   disp(skullstrip);
   system(skullstrip);
      
   n4 = sprintf('N4BiasFieldCorrection -i %s -x %s -o %s', name_brain, name_mask, name_restore);
   disp(n4);
   system(n4);
end;


