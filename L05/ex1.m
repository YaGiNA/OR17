run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');
addpath('/usr/local/class/object/MATLAB/sift');
load('codebook.mat');
load('db_pos.mat');
load('db_neg.mat');
bovw_pos=zeros(500,100);
bovw_neg=zeros(500,100);

for j=1:100
    X=rgb2gray(imread(pos_list{j}));
    [pnt_pos,desc_pos] = sift_rand(X,'randn',1500);
    for i=1:size(pnt_pos,2)
        desc_array = ones(128, 500) .* desc_pos(:, i);
        intsct = (desc_array - codebook);
        [M, index] = min(intsct);
        bovw_pos(index,j)=bovw_pos(index,j)+1;
    end
end

pr_pos = sum(bovw_pos) + 1;
pr_pos = pr_pos/sum(pr_pos);
pr_pos = log(pr_pos);

rp=randperm(900); 
neg_imgs = neg_list(:, rp(1:100));
for j=1:100
    X=rgb2gray(imread(neg_imgs{j}));
    [pnt_neg,desc_neg] = sift_rand(X,'randn',1500);
    for i=1:size(pnt_neg,2)
        desc_array = ones(128, 500) .* desc_neg(:, i);
        intsct = (desc_array - codebook);
        [M, index] = min(intsct);
        bovw_neg(index,j)=bovw_neg(index,j)+1;
    end
end

pr_neg = sum(bovw_neg) + 1;
pr_neg = pr_neg/sum(pr_neg);
pr_neg = log(pr_neg);

images = [pos_list neg_imgs];
ok = 0;
ng = 0;
for k=1:200
    X=rgb2gray(imread(images{k}));
    [pnt,im] = sift_rand(X,'randn',1500);
    max0=max(im); 
    idx=[];
    for i=1:max0
        idx = [idx find(im>=i)];
    end
    pr_im_pos=sum(pr_pos(idx));
    pr_im_neg=sum(pr_neg(idx));
    if pr_im_pos < pr_im_neg
        if k < 100
            ng = ng + 1;
        else
            ok = ok + 1;
        end
    else
        if k < 100
            ok = ok + 1;
        else
            ng = ng + 1;
        end
    end
end
rate = ok / (ok + ng);
fprintf('classification rate: %.5f\n',rate);
%{
実行例

%}