%Resize the images with FSL
%Questions and comments chen.yasheng@gmail.com


function resize_image_fsl_center(name_in, name_out, dimx_out, dimy_out, dimz_out)

   %addpath('../Supporting/NIFTI_yasheng');

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   nii = load_untouch_nii(name_in);
   px = nii.hdr.dime.pixdim(2);
   py = nii.hdr.dime.pixdim(3);
   pz = nii.hdr.dime.pixdim(4);
   img = nii.img;

   [dimx, dimy, dimz] = size(img);

   if dimx_out > dimx
      sx=-round((dimx_out-dimx)/2);
   else
      sx=round((dimx-dimx_out)/2);
   end;

   if dimy_out > dimy
      sy=-round((dimy_out-dimy)/2);
   else
      sy=round((dimy-dimy_out)/2);
   end;

   if dimz_out == -1,
      sz=0;
   else
      if dimz_out > dimz
         sz=-round((dimz_out-dimz)/2);
      else
         sz=round((dimz-dimz_out)/2);
      end;
   end;

   fsl = sprintf('fslroi %s %s %d %d %d %d %d %d', name_in, name_out, sx, dimx_out, sy, dimy_out, sz, dimz_out);
   disp(fsl);
   system(fsl);

   clear nii img;

