I1=imresize(im2double(rgb2gray(imread('suzuka-wheel1.jpg'))), 0.4);
[pnt1,desc1]=sift(I1);
I2=imresize(im2double(rgb2gray(imread('suzuka-wheel2.JPG'))), 0.15);
[pnt2,desc2]=sift(I2);
tic;
matches=siftmatch( desc1, desc2 ) ;  % 対応点を求めます 
fprintf('Matched in %.3f \n', toc) ; % 実行時間の表示
figure; colormap gray;
plotmatches(I1,I2,pnt1(1:2,:),pnt2(1:2,:),matches) ;