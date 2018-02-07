% まず addpath で MatConvNetのパスを指定します．
addpath('/usr/local/class/object/matconvnet');
addpath('/usr/local/class/object/matconvnet/matlab');

% 初期設定関数を最初にかならず呼びます．
vl_setupnn;

load('filelist-others.mat');
load('dcnn-others.mat', 'dcnn_list');

% 学習済モデルの読み込み
net = load('imagenet-caffe-alex.mat') ;

data_pos = dcnn_list(:, 1:200);
data_neg = dcnn_list(:, 201:800);
cv=5;
idx=[1:200];
accuracy=zeros(1, 5);
result = zeros(1, 800);

% idx番目(idxはcvで割った時の余りがi-1)が評価データ
% それ以外は学習データ
for i=1:cv
  eval_pos =data_pos(:, find(mod(idx,cv)==(i-1)));
  train_pos=data_pos(:, find(mod(idx,cv)~=(i-1)));
  eval_neg =data_neg(:, find(mod(idx,cv)==(i-1)));
  train_neg=data_neg(:, find(mod(idx,cv)~=(i-1)));

  eval=[eval_pos eval_neg];
  train=[train_pos train_neg];

  eval_label =[ones(size(eval_pos, 2),1); ones(size(eval_neg, 2),1)*(-1)];
  train_label=[ones(size(train_pos, 2),1); ones(size(train_neg, 2),1)*(-1)];
  db = [];
  % 学習データのBoFベクトルは既にtrainが含んでいる
  
  % 評価データを非線型SVMで分類する
  ac = [];
  tic;
    model=fitcsvm(train', train_label,'KernelFunction','linear','KernelScale','auto');
    [plabel,score]=predict(model,eval');
  toc;
  pcount=numel(find((plabel .* eval_label)==1));
  ncount=numel(find((plabel .* eval_label)==-1));
  accuracy(i) = pcount/(pcount+ncount);
    for k = 1:numel(plabel)
      % 個々の分類正誤を出力(正: 0 誤: 1)
      if i == 1
          index = k * 5;
      else
          index = (k-1) * 5 + i - 1;
      end
      result(index) = abs(plabel(k) - eval_label(k))/2;
  end
  
end
fprintf('accuracy: %f\n',mean(accuracy))
% ポジ/ネガで誤りだった画像をそれぞれ5枚ずつ表示する
load('filelist-others.mat');
res_pos = result(1:200);
res_neg = [zeros(1, 200) result(201:800)];
fails_pos = list([find(res_pos == 1)]);
fails_neg = list([find(res_neg == 1)]);
for i=1:2
    subplot(2, 2, i); imshow(fails_pos{i});
    subplot(2, 2, i+2); imshow(fails_neg{i});
end

%{
前準備: listを対象にすべての画像のDCNN特徴量をもつリストを
tic; mk_dcnnlist.m(list) toc;
で作成すること

実行例
dcnn_svn_dcnn
経過時間は 0.132993 秒です。
経過時間は 0.132959 秒です。
経過時間は 0.128154 秒です。
経過時間は 0.134908 秒です。
経過時間は 0.130479 秒です。
accuracy: 0.987500
%}