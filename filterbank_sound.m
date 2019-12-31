function filterbank_sound (filename, bands, mode)
  factor = 0.2;
  #(y, x, z)?! Okay then.
  [audioin, fs] = audioread(filename);
  fnameroot = substr(filename, 1, -4);
  currbase(:, :) = audioin(:, :);
  bandset = zeros(size(audioin, 1), size(audioin, 2), mode+1);
  if mode > 0
    mode(1) = 1;
  endif
  for i = 0:bands-1
    for j = i:i+mode
      n = 2**(j+1);
      soundFilter = [1:n, flip(1:n-1)];
      soundFilter = soundFilter / sum(soundFilter);
      for k = 1:size(audioin, 2)
        bandset(:, k, 1+j-i) = currbase(:, k)-rot90(conv(rot90(currbase, 1)(1+size(audioin, 2)-k, :), soundFilter, "same"), -1);
      endfor
    endfor
    curraudio(:, :) = bandset(:, :, 1);
    if mode > 0
        curraudio(:, :) = curraudio(:, :)-(factor)*bandset(:, :, 2);
        curraudio(:, :) = curraudio(:, :)*(1/(1-factor));
    endif
    savename = [fnameroot, int2str(i+1), ".flac"];
    printf ("Processed band %d, saving as %s\n", i+1, savename);
    audiowrite(savename, curraudio, fs)
    currbase(:, :) = currbase(:, :)-curraudio(:, :);
  endfor
  savename = [fnameroot, "R.flac"];
  printf ("Saving residual as %s\n", savename);
  audiowrite(savename, currbase, fs)
endfunction
