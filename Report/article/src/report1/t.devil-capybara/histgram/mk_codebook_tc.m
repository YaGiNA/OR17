function [desc codebook]=mk_codebook_tc()
 
  k=500;
  addpath('/usr/local/class/object/MATLAB/sift');
  run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');
 
  list=flist_thisdir();
  % t.devilをpositive, capybaraをnegativeとします．
 
  % 400枚の画像から10万点のSIFT 特徴をrandで抽出．
  % SIFTの主方向が同点で複数あるときは，１つの特徴点から
  % 複数のdescriptorを生成するので，通常は10万点より多くなります．
  desc=[];
  for i=1:length(list)
    I=im2double(rgb2gray(imread(list{i})));
    fprintf('reading [%d] %s\n',i,list{i});
    [f d]=sift_rand(I,'randn',500);
    desc=[desc d];
  end
 
  size(desc)
  [codebook, idx]=vl_kmeans(desc,k);
  size(codebook)
  % codebook を save します．
  save('codebook-tc.mat','codebook');
  % file list も save しておきます．
  save('filelist-tc.mat','list');