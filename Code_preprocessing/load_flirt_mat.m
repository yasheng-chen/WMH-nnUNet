
function mat_out = load_flirt_mat(name_in)

   mat_out = zeros(4, 4);

   fid = fopen(name_in,  'rt');

   for i=1:4,
      for j=1:4,
         mat_out(i,j) = fscanf(fid, '%f', 1);
      end;
   end;

   fclose(fid);
