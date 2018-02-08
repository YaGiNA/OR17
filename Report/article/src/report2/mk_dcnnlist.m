function [ dcnn_list ] = mk_dcnnlist( images )
%use_dcnn 渡された画像を元にDCNNを実行し、結果を返す関数
% まず addpath で MatConvNetのパスを指定します．
addpath('/usr/local/class/object/matconvnet');
addpath('/usr/local/class/object/matconvnet/matlab');

% 初期設定関数を最初にかならず呼びます．
vl_setupnn;

% 学習済モデルの読み込み
net = load('imagenet-caffe-alex.mat') ;

dcnn_list=[];
  for i=1:numel(images)
    im = imread(images{i});
    fprintf('reading [%d] %s\n',i,images{i});
    im_ = single(im) ; % note: 0-255 range
    im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
    im_ = im_ - net.meta.normalization.averageImage ;
    % CNNの実行．画像をネットワークに流します．(feed-forward)
    res = vl_simplenn(net, im_);

    dcnnf=squeeze(res(end-3).x);
    dcnnf=dcnnf/norm(dcnnf);
    dcnn_list = [dcnn_list dcnnf];
  end
end
