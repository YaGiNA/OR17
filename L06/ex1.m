% まず addpath で MatConvNetのパスを指定します．
addpath('/usr/local/class/object/matconvnet');
addpath('/usr/local/class/object/matconvnet/matlab');
addpath('/usr/local/class/object/liblinear/matlab');

% 初期設定関数を最初にかならず呼びます．
vl_setupnn;

% 学習済モデルの読み込み
net = load('imagenet-caffe-alex.mat') ;
% 他にも2通りダウンロードしてあります．
% net = load('imagenet-vgg-f.mat'); % 高速版のネットワーク
% net = load('imagenet-vgg-verydeep-16.mat'); % 高精度版のネットワーク

load('filelist.mat');
fc6_list=[];
fc7_list=[];
fc8_list=[];
% 画像の読み込み, リサイズ(224x224)，平均画像の引き算
for i = 1:200
    im = imread(list{i}) ;
    fprintf('reading [%d] %s\n',i,list{i});
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
    fc6=squeeze(res(end-1).x);
    fc6=fc6/norm(fc6);
    fc7=squeeze(res(end-3).x);
    fc7=fc7/norm(fc7);
    fc8=squeeze(res(end-5).x);
    fc8=fc8/norm(fc8);
    fc6_list = [fc6_list fc6];
    fc7_list = [fc7_list fc7];
    fc8_list = [fc8_list fc8];
end


[fc6_pcount, fc6_ncount] = use_svg(fc6_list);
fprintf('classification rate: %.5f\n',fc6_pcount/(fc6_pcount+fc6_ncount));

[fc7_pcount, fc7_ncount] = use_svg(fc7_list);
fprintf('classification rate: %.5f\n',fc6_pcount/(fc6_pcount+fc6_ncount));

[fc8_pcount, fc8_ncount] = use_svg(fc8_list);
fprintf('classification rate: %.5f\n',fc8_pcount/(fc8_pcount+fc8_ncount));

%{
経過時間は 0.065334 秒です。
classification rate: 0.99000
経過時間は 0.076750 秒です。
classification rate: 0.99000
経過時間は 0.067333 秒です。
classification rate: 0.96000
%}