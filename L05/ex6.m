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

load('filelist.mat');
dcnn_list=[];
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

    dcnnf=squeeze(res(end-3).x);
    dcnnf=dcnnf/norm(dcnnf);
    dcnn_list = [dcnn_list dcnnf];
end
save('dcnn.mat', 'dcnn_list');
load('dcnn.mat');

dcnn_pos = dcnn_list(1:100, :);
dcnn_neg = dcnn_list(101:200, :);
 
training_label=[ones(100,1); ones(100,1)*(-1)] ;
data=[dcnn_pos; dcnn_neg];
 

data3=repmat(sqrt(abs(data)).*sign(data),[1 3]) .* ...
  [0.8*ones(size(data)) 0.6*cos(0.6*log(abs(data)+eps)) 0.6*sin(0.6*log(abs(data)+eps))];
 
training_data=data3;
 
testing_label=training_label;
testing_data=training_data;
tic;
model=fitcsvm(training_data, training_label,'KernelFunction','rbf', 'KernelScale','auto');
 
[plabel,score]=predict(model,testing_data);
toc;
 
pcount=numel(find((plabel .* testing_label)==1));
ncount=numel(find((plabel .* testing_label)==-1));

fprintf('classification rate: %.5f\n',pcount/(pcount+ncount));

%{
実行例
経過時間は 0.199447 秒です。
classification rate: 0.94500
%}
