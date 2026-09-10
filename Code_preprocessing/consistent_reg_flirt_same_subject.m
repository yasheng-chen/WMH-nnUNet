%Registration between the images fromt the same subject
%Questions and comments chen.yasheng@gmail.com

function consistent_reg_flirt_same_subject(name_in, name_ref, name_mat, name_out, rotation)

   flirt = sprintf('flirt -in %s -ref %s -omat %s -o %s -searchrx %d %d -searchry %d %d -searchrz %d %d -cost mutualinfo', name_in, name_ref, name_mat, name_out, -rotation, rotation, -rotation, rotation, -rotation, rotation);
   system(flirt);

   %%%%%%%%check .mat and rerun registration if necessary
   if check_flirt_mat_rerun(name_mat) ==1
      flirt = sprintf('flirt -in %s -ref %s -omat %s -o %s -searchrx %d %d -searchry %d %d -searchrz %d %d', name_in, name_ref, name_mat, name_out, -rotation, rotation, -rotation, rotation, -rotation, rotation);
      system(flirt);
   else
      return;
   end;
      
   %%%%%%%%check .mat and rerun registration if necessary
   if check_flirt_mat_rerun(name_mat)==1
      flirt = sprintf('flirt -in %s -ref %s -omat %s -o %s -searchrx %d %d -searchry %d %d -searchrz %d %d -cost mutualinfo -dof 6', name_in, name_ref, name_mat, name_out, -rotation, rotation, -rotation, rotation, -rotation, rotation);
      system(flirt);
   else
      return;
   end;

   %%%%%%%%check .mat and rerun registration if necessary
   if check_flirt_mat_rerun(name_mat)==1
      flirt = sprintf('flirt -in %s -ref %s -omat %s -o %s -searchrx %d %d -searchry %d %d -searchrz %d %d -dof 6', name_in, name_ref, name_mat, name_out, -rotation, rotation, -rotation, rotation, -rotation, rotation);
      system(flirt);
   else
      return;
   end;

   %%%%%%%%check .mat and rerun registration if necessary
   if check_flirt_mat_rerun(name_mat)==1
      flirt = sprintf('flirt -in %s -ref %s -omat %s -o %s -searchrx %d %d -searchry %d %d -searchrz %d %d -cost mutualinfo -noresample', name_in, name_ref, name_mat, name_out, -rotation, rotation, -rotation, rotation, -rotation, rotation);
      system(flirt);
   else
      return;
   end;

   %%%%%%%%check .mat and rerun registration if necessary
   if check_flirt_mat_rerun(name_mat)==1
      flirt = sprintf('flirt -in %s -ref %s -omat %s -o %s -searchrx %d %d -searchry %d %d -searchrz %d %d -noresample', name_in, name_ref, name_mat, name_out, -rotation, rotation, -rotation, rotation, -rotation, rotation);
      system(flirt);
   else
      return;
   end;

   %%%%%%%%check .mat and rerun registration if necessary
   sign_rerun = check_flirt_mat_rerun(name_mat);

   if sign_rerun == 1
      fprintf('%s to %s reg failed!\n', name_in, name_ref);
   end;

