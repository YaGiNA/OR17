run('/usr/local/class/object/matconvnet/matlab/vl_setupnn');

img=im2single(imresize(rgb2gray(imread('MP4-4.jpg')), 0.1));
goal=edge(img,'canny');

% convのフィルタ重みは乱数で初期化します．
w=randn(3,3,1,1,'single');

% 学習率と繰り返し回数を設定します．
tr=0.000001;
epoch=10000;

for i=1:epoch
  % 3x3フィルタで画像が小さくならないように padding 1を設定して，
  % 濃淡画像imgに対してフィルタを畳み込み．
  out = vl_nnconv(img, w, [],'pad',1) ;
  % 損失関数の微分値dE/dout (=out-goal) 
  dzdy=out-goal;
  % dE/dout を渡すと，dE/dw を自動計算 (以下の関数が convの微分を計算)
  [dzdx, dzdw] = vl_nnconv(img, w, [], dzdy, 'pad',1) ;
  % dE/dw を画像のピクセル数で割った値に，学習率 tr を掛けて，重みw を更新．
  w = w - tr * dzdw / (size(img,1)*size(img,2));
  % 50回ごとに損失関数の値を表示します．小さくなれば学習が進んでいます．
  if mod(i,50)==0
    loss=0.5*sum((out(:)-goal(:)).^2);
    fprintf('[%d] %f\n',i,loss);
  end
end
% 最後に画像を出力．代わりに表示でも構いません．
% どれだけ学習したフィルタが canny edge detectorに近づいたでしょうか？
imwrite(goal,'edge.jpg');
imwrite(out ,'out100d.jpg'); 