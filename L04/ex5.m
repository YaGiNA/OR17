run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');
addpath('/usr/local/class/object/MATLAB/sift');

load('db_pos.mat');
load('db_neg.mat');
rp=randperm(900); 
neg_imgs = neg_list(:, rp(1:100));
images = [pos_list neg_imgs];
code=zeros(200,500);
for j=1:200
    X=rgb2gray(imread(images{j}));
    [pnt_pos,desc_pos] = sift_rand(X,'randn',1500);
    for i=1:size(pnt_pos,2)
        desc_array = ones(128, 500) .* desc_pos(:, i);
        intsct = (desc_array - codebook);
        [M, index] = min(intsct);
        code(j, index)=code(j, index)+1;
    end
end

dist=squareform(pdist(code(1:200,:)));
  
ok=0;
ng=1;

 
dist=dist + 10000*eye(size(dist));
 
for i=1:100
  [v idx]=min(dist(i,:));
  if idx<=100 
    ok=ok+1;
  else
    ng=ng+1;
  end
end
for i=101:200
  [v idx]=min(dist(i,:));
  if idx<=100 
    ng=ng+1;
  else
    ok=ok+1;
  end
end
 
fprintf('classification rate: %.5f\n',ok/(ok+ng));

function code=mk_code_vec()
 
  load('codebook.mat','codebook');
  load('filelist.mat','list');
  dim=size(codebook,1);
  k=size(codebook,2);
 
  addpath('/usr/local/class/object/MATLAB/sift');
 
  code=[];
 
  for i=1:length(list)
    I=im2double(rgb2gray(imread(list{i})));
    fprintf('reading [%d] %s\n',i,list{i});
    [f d]=sift_rand(I,'randn',2000);
    nd=size(d,2);
    d1=repmat(d',k,1);
    c1=reshape((ones(nd,1)*reshape(codebook',1,dim*k)),k*nd,dim);
    dist=sum(((d1-c1).^2)');
    dist=reshape(dist,nd,k);
    [m idx]=min(dist');
    c=histcounts(idx,k);
    c=c/sum(c);
    code=[code c'];
  end
end

%{
実行例
classification rate: 0.61194
%}