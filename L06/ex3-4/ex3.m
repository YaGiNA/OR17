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
im = imread('MP4-4.jpg') ;
im_ = single(im) ; % note: 0-255 range
im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
im_ = im_ - net.meta.normalization.averageImage ;

res = vl_simplenn(net, im_);

figure; clf ; colormap gray ;
vl_imarraysc(squeeze(res(2).x),'spacing',2)

figure; clf ; colormap gray ;
vl_imarraysc(squeeze(res(6).x),'spacing',2)

figure; clf ; colormap gray ;
vl_imarraysc(squeeze(res(10).x),'spacing',2)


im = imread('bagel.jpg') ;
im_ = single(im) ; % note: 0-255 range
im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
im_ = im_ - net.meta.normalization.averageImage ;

res = vl_simplenn(net, im_);

figure; clf ; colormap gray ;
vl_imarraysc(squeeze(res(2).x),'spacing',2)

figure; clf ; colormap gray ;
vl_imarraysc(squeeze(res(6).x),'spacing',2)

figure; clf ; colormap gray ;
vl_imarraysc(squeeze(res(10).x),'spacing',2)
