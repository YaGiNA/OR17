% まず addpath で MatConvNetのパスを指定します．
addpath('/usr/local/class/object/matconvnet');
addpath('/usr/local/class/object/matconvnet/matlab');

% 初期設定関数を最初にかならず呼びます．
vl_setupnn;

% 学習済モデルの読み込み
nets = {'imagenet-caffe-alex.mat', 'imagenet-vgg-f.mat', 'imagenet-vgg-verydeep-16.mat'};
tic;
dcnn_list_normal=analyse(nets{1}, false);
[normal_pcount, normal_ncount] = use_svg(dcnn_list_normal);
toc;
fprintf('classification rate: %.5f\n',normal_pcount/(normal_pcount+normal_ncount));

tic;
dcnn_list_hspeed=analyse(nets{2}, false);
[hspeed_pcount, hspeed_ncount] = use_svg(dcnn_list_hspeed);
toc;
fprintf('classification rate: %.5f\n',hspeed_pcount/(hspeed_pcount+hspeed_ncount));

tic;
dcnn_list_deeper=analyse(nets{3}, true);
[deeper_pcount, deeper_ncount] = use_svg(dcnn_list_deeper);
toc;
fprintf('classification rate: %.5f\n',deeper_pcount/(deeper_pcount+deeper_ncount));

%{
実行例
経過時間は 22.261950 秒です。
classification rate: 0.94500

経過時間は 19.360663 秒です。
classification rate: 0.95500

経過時間は 94.014785 秒です。
classification rate: 0.96500

%}