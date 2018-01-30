% まず addpath で MatConvNetのパスを指定します．
addpath('/usr/local/class/object/matconvnet');
addpath('/usr/local/class/object/matconvnet/matlab');

% 初期設定関数を最初にかならず呼びます．
vl_setupnn;

% 学習済モデルの読み込み
net = load('imagenet-caffe-alex.mat') ;
% 他にも2通りダウンロードしてあります．
% net = load('imagenet-vgg-f.mat'); % 高速版のネットワーク
% net = load('imagenet-vgg-verydeep-16.mat'); % 高精度版のネットワーク

% 画像の読み込み, リサイズ(224x224)，平均画像の引き算
im = imread('throne.jpg') ;
im_ = single(im) ; % note: 0-255 range
im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
im_ = im_ - net.meta.normalization.averageImage ;

%ただし，vgg-verydeep-16の時だけ，
% im_ = im_ - net.meta.normalization.averageImage ;
%を
% im_ = im_ - repmat(net.meta.normalization.averageImage,net.meta.normalization.imageSize(1:2));
%としてください．これは平均画像の代わりに，RGBそれぞれでの平均値のみが記録されているためです．

% CNNの実行．画像をネットワークに流します．(feed-forward)
res = vl_simplenn(net, im_);

% 結果の表示
% res(end).x に1000次元のクラス確率が入ります．
scores = squeeze(res(end).x);  % squeeze で1x1x1000を1000次元ベクトル化
[sorted_scores idx] = sort(scores,'descend'); % 降順にソートし，確率上位のクラスを求める．

% net.meta.classes.description{n} でクラス名を表示．
% 上位５個の候補を表示 (... は１つの文を複数の行で記述する場合に使います)
for i=1:5 
  fprintf('[%d] (class id:%d) (score: %.5f) %s\n',i,idx(i), ...
  sorted_scores(i), net.meta.classes.description{idx(i)});
end

% fprintf('%s\n',net.meta.classes.description{:}) で全クラス名が表示可能