% まず addpath で MatConvNetのパスを指定します．
addpath('/usr/local/class/object/matconvnet');
addpath('/usr/local/class/object/matconvnet/matlab');
run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');

% 初期設定関数を最初にかならず呼びます．
vl_setupnn;

% 学習済モデルの読み込み
net = load('imagenet-caffe-alex.mat') ;
% 他にも2通りダウンロードしてあります．
% net = load('imagenet-vgg-f.mat'); % 高速版のネットワーク
% net = load('imagenet-vgg-verydeep-16.mat'); % 高精度版のネットワーク

% 画像の読み込み, リサイズ(224x224)，平均画像の引き算
im = imread('bagel.jpg') ;
im_ = single(im) ; % note: 0-255 range
im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
im_ = im_ - net.meta.normalization.averageImage ;

res = vl_simplenn(net, im_);
[pr idx]=max(res(end).x);
dzdy=zeros(1,1,1000);
dzdy(1,1,idx)=1;
res = vl_simplenn(net, im_, dzdy);

out=abs(res(1).dzdx); % 絶対値を取ります．
out=max(out,[],3);    % RGB のうちの最大値を取ります．
maxv=max(out(:));     % 最大値を求めます．  
out=out/maxv;         % 最大値で割って，値が0～1の間になるようにします．

imshow(out);