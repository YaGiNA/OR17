function [ hist ] = mk_hist( image )
%mk_hist 受け取った画像pathからヒストグラムを返す
  I=imread(image);
  RED=I(:,:,1); GREEN=I(:,:,2); BLUE=I(:,:,3);
  I_64=floor(double(RED)/64) *4*4 + floor(double(GREEN)/64) *4 + floor(double(BLUE)/64);
  I_64_vec=reshape(I_64,1,numel(I_64));
  i=histc(I_64_vec, [0:63]);
  hist=i / sum(i);
end

