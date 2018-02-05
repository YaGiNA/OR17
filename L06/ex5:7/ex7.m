addpath('/usr/local/class/object/matconvnet');
addpath('/usr/local/class/object/matconvnet/matlab');
vl_setupnn;

% 学習済モデルの読み込み．AlexNetを用いる．
% DeepDreamは，GoogleNetを一般には使うことが多いが，AlexNetでも可能．
net = load('imagenet-caffe-alex.mat') ;

% 画像の読み込み, 平均画像のリサイズ，引き算．
% 認識の時は画像を入力縮小したが，ここでは平均画像を入力画像に合わせてリサイズする．
% ただし，fc6, fc7を強調するときは，入力画像を 224x224にする必要がある．
% そうしないとエラーになるので，要注意．

im = imresize(imread('MP4-4.jpg'), 0.0925) ;
imsize=size(im);
avg = imresize(net.meta.normalization.averageImage,imsize(1:2));
im_ = single(im);
im_ = im_ - avg;

% 不要レイヤーの除去．pool5まで残す．
net.layers(16:21)=[];

lr=0.01;  % learning rate 学習率
ite=1000; % iteration number 繰り返し回数

for i=1:ite
  if mod(i,25)==0  % 25回ごとに表示画像を更新．
    % 更新値の最大値を表示．この値が 1～10程度が適切．
    fprintf('%d %f\n',i,max(reshape(res(1).dzdx,1,numel(res(1).dzdx)))*lr);
    out = uint8(im_ + avg);
    clf;
    imshow(out); % 画像出力
  end
  res = vl_simplenn(net, im_);
  dzdy = res(end).x ;
  res = vl_simplenn(net, im_, dzdy);
  im_ = im_ + lr * res(1).dzdx;
end
out = uint8(im_ + avg);
imwrite(out,'out-ex7.jpg');