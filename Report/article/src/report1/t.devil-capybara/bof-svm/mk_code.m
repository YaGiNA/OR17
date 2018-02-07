function code = mk_code(images)
%mk_code 入力画像をコードブックを元にBoFベクトル化する
  load('codebook-tc.mat','codebook');
  k=size(codebook,2);
 
  addpath('/usr/local/class/object/MATLAB/sift');
 
  code=[];
 
  for i=1:length(images)
    c=zeros(k,1);
    I=im2double(rgb2gray(imread(images{i})));
    fprintf('reading [%d] %s\n',i,images{i});
    [f d]=sift_rand(I,'randn',2000);
 
    for j=1:size(d,2)
      s=zeros(1,k);
      for t=1:128
        s=s+(codebook(t,:)-d(t,j)).^2;
      end
      [dist sidx]=min(s);
      c(sidx,1)=c(sidx,1)+1.0;
    end
    c=c/sum(c);
    code=[code c];
  end
  save('all_bovw.mat', 'code');
end

