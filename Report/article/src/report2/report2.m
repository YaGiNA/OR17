% report2
% 学習画像のDCNN特徴量を取得する
% ポジティブ/ネガティブ画像へのpathを収集/保存
list_others = flist_others();
list_thisdir = flist_thisdir();

% ポジティブ画像から学習に使用する50枚のみ取り出す
n = 50;
list = [list_thisdir(1:n) list_others];

dcnn_train = mk_dcnnlist(list);

% SVM用のラベルも作成しておく
dcnn_label = [ones(n, 1); ones(numel(list_others), 1)*(-1)];

% 評価用画像を取り出す(n以下は学習用として使用済)
eval = list_thisdir(n+1:300);
dcnn_eval = mk_dcnnlist(eval);

% 評価データを非線型SVMで分類する
model=fitcsvm(dcnn_train', dcnn_label,'KernelFunction','linear','KernelScale','auto');
[label,score]=predict(model,dcnn_eval');

% 降順 ('descent') でソートして，ソートした値とソートインデックスを取得します．
[sorted_score,sorted_idx] = sort(score(:,2),'descend');

% list{:} に画像ファイル名が入っているとして，
% sorted_idxを使って画像ファイル名，さらに
% sorted_score[i](=score[sorted_idx[i],2])の値を出力します．
% fileID = fopen('score25.txt','w');
fileID = fopen('score50.txt','w');
for i=1:100;
  fprintf(fileID, '%s %f\n',eval{sorted_idx(i)},sorted_score(i));
end
fclose(fileID);
