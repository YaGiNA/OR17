addpath('/usr/local/class/object/liblinear/matlab');
load('filelist-tc.mat', 'list');
data_pos = list(1:200);
data_neg = list(201:400);
% load('filelist-others.mat', 'list_others');
cv=5;
idx=[1:200];
accuracy=[];

% idx番目(idxはcvで割った時の余りがi-1)が評価データ
% それ以外は学習データ
for i=1:cv
  eval_pos =data_pos(find(mod(idx,cv)==(i-1)));
  train_pos=data_pos(find(mod(idx,cv)~=(i-1)));
  eval_neg =data_neg(find(mod(idx,cv)==(i-1)));
  train_neg=data_neg(find(mod(idx,cv)~=(i-1)));

  eval=[eval_pos eval_neg];
  train=[train_pos train_neg];

  eval_label =[ones(numel(eval_pos),1); ones(numel(eval_neg),1)*(-1)];
  train_label=[ones(numel(train_pos),1); ones(numel(train_neg),1)*(-1)];
  db = [];
  % 学習データのカラーヒストグラムを収めたdbリストを作成
  for j=1:size(train, 2)
    histgram = mk_hist(train{j});
    db = [db; histgram];
  end
  % 評価データのカラーヒストグラムに最も近いdbの行を探索
  ac = [];
  for k=1:size(eval, 2)
      histgram = mk_hist(eval{k});
      sim = [];
      for i=1:size(db)
          sim = [sim sum(min(db(i, :), histgram))];
      end
      [similar, idx_sim] = min(sim);
      tf = train_label(idx_sim);
      type = eval_label(k);
      % 最も近い画像属性が評価画像の属性に誤っていると0
      % 正しければ1がacに格納される
      ac = [ac abs(tf+type)/2];
  end
  accuracy=[accuracy ac];
end
a = sum(accuracy) / size(accuracy, 2);
fprintf('accuracy: %f\n',mean(a))
%{
t.devil-capybara
accuracy: 0.345000
%}