function [desc codebook]=mk_codebook()
 
  k=500;
  addpath('/usr/local/class/object/MATLAB/sift');
  run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');
 
  list=flist();
  % 各種類100枚ずつあることを前提とする．
  % catをpositive, それ以外をnegativeとします．
  pos_idx=[1:100];
  neg_idx=randperm(900,100)+100; 
  %900までの重複しない自然数を100個生成して，100を足す
  list=list([pos_idx neg_idx]);
 
  % 200枚の画像から10万点のSIFT 特徴をrandで抽出．
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
  save('codebook.mat','codebook');
  % file list も save しておきます．
  save('filelist.mat','list');