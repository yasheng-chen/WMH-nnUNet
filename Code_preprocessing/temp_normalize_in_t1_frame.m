%The driving program for FLAIR and T1 normalization
%Questions and comments chen.yasheng@gmail.com

function temp_normalize_in_t1_frame(name_dir)

addpath('./NIFTI_yasheng');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
name_dir = '../ADNI/T1';
name_dir = '../ADNI/2D_FLAIR_to_T1';
name_dir = '../ADNI/3D_FLAIR_to_T1';

name_dir = '../ADRC/T1';
name_dir = '../ADRC/2D_FLAIR_to_T1';
name_dir = '../ADRC/3D_FLAIR_to_T1';
%}
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
names_all = sprintf('%s/*_vox1_brain_restore.nii.gz',    name_dir);
names_all = dir(names_all);
nums_all = length(names_all);

for i=1:nums_all,
   name_image  = sprintf('%s/%s', name_dir, names_all(i).name);
   name_mask   = strrep(name_image, '_restore.nii.gz', '_mask.nii.gz');
            
   name_out = strrep(name_image, '.nii.gz', '_normalized.nii.gz');
      
   if i==1
      disp(name_image);
      disp(name_mask);
      disp(name_out);
   end;
   
   if ~exist(name_image) | ~exist(name_mask) | exist(name_out)
      continue;
   end;
         
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   nii = load_untouch_nii(name_image);      
   px=nii.hdr.dime.pixdim(2);
   py=nii.hdr.dime.pixdim(3);
   pz=nii.hdr.dime.pixdim(4);

   image = nii.img;
   
   nii = load_untouch_nii(name_mask);
   mask = nii.img;
       
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   image_normalized = image_normalization_with_mean_std_mask_with_threshold(image, mask, 3, 1);
   I = find(mask==0);
   image_normalized(I) = -1;
   clear I;
      
   save_nii_yasheng(image_normalized, px, py, pz, 16, name_out);
   fsl = sprintf('fslcpgeom %s %s', name_image, name_out); 
   disp(fsl);
   system(fsl);
      
   clear fsl nii image mask name_image name_mask name_out image_normalized I;
end;
   
