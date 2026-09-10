%Image normalization to the range [-threshold, threshold]
%Questions and comments chen.yasheng@gmail.com

function im_out = image_normalization_with_mean_std_mask_with_threshold(im_in, mask, times_sigma, threshold)

   im_out = zeros(size(im_in));

   I = find(mask>0);
   val = im_in(I);

   meanv = mean(val);
   stdv = std(val);

   val = (val-meanv)/(times_sigma*stdv);
   J1 = find(val>threshold);
   J2 = find(val<-threshold);

   val(J1) = threshold;
   val(J2) = -threshold;

   clear J1 J2;

   im_out(I) = val;
   clear I val;

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   I0 = find(mask==0);
   im_out(I0) = -threshold;
