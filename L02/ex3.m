X=webread('http://mm.cs.uec.ac.jp/lion.jpg');
GRAY2 = rgb2gray(X);
RED=X(:,:,1); GREEN=X(:,:,2); BLUE=X(:,:,3);
X64=floor(double(RED)/64) *4*4 + floor(double(GREEN)/64) *4 + floor(double(BLUE)/64);
subplot(1,3,1),imshow(X);
subplot(1,3,2),imshow(GRAY2);
subplot(1,3,3),imshow(X64*4);