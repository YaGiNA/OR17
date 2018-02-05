run('/usr/local/class/object/matconvnet/matlab/vl_setupnn');

% img=im2single(imresize(rgb2gray(imread('MP4-4.jpg')), 0.1));
% img=im2single(rgb2gray(imread('bagel.jpg')));
img=im2single(imresize(rgb2gray(imread('suzuka-wheel.jpg')), 0.17));
goal=edge(img,'canny');

w=randn(3,3,1,20,'single');
w2=randn(1,1,20,1,'single');

% 学習率と繰り返し回数を設定します．
tr=0.001;
epoch=10000;

for i=1:epoch
  % 3x3フィルタで画像が小さくならないように padding 1を設定して，
  % 濃淡画像imgに対してフィルタを畳み込み．
  x2= vl_nnconv(img, w,  [],'pad',1) ;
  x3= vl_nnrelu(x2); 
  % out = vl_nnconv(x2, w2, []) ;
  out = vl_nnconv(x3, w2, []) ;
  % 損失関数の微分値dE/dout (=out-goal) 
  dzdy=out-goal;
  % dE/dout を渡すと，dE/dw を自動計算 (以下の関数が convの微分を計算)
  [dzdx, dzdw] = vl_nnconv(x2, w2, [], dzdy) ;
  w2 = w2 - tr * dzdw / (size(x2,1) * size(x2,2));
  [dzdx, dzdw] = vl_nnconv(img, w , [], dzdx, 'pad',1) ;
  w = w - tr * dzdw / (size(img,1)*size(img,2));
  if mod(i,50)==0
    loss=0.5*sum((out(:)-goal(:)).^2);
    fprintf('[%d] %f\n',i,loss);
  end
end
% 最後に画像を出力．代わりに表示でも構いません．
% どれだけ学習したフィルタが canny edge detectorに近づいたでしょうか？
% imwrite(out ,'out2-wheel.jpg'); 
imwrite(out ,'out3-wheel.jpg'); 

%{
 実行例: PDF参照
%}