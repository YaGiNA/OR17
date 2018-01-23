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

pos1 = rgb2gray(imread(pos_list{1}));
pos2 = rgb2gray(imread(pos_list{2}));
neg1 = rgb2gray(imread(neg_imgs{1}));
neg2 = rgb2gray(imread(neg_imgs{2}));

[I, pos1_sim] = max(bovw_pos(:, 1));
[I, pos2_sim] = max(bovw_pos(:, 2));
[I, neg1_sim] = max(bovw_neg(:, 1));
[I, neg2_sim] = max(bovw_neg(:, 2));

subplot(4, 2, 1),imshow(imread(char(pos_list(1))));
subplot(4, 2, 2),imshow(imread(char(pos_list(pos1_sim))));
subplot(4, 2, 3),imshow(imread(char(pos_list(2))));
subplot(4, 2, 4),imshow(imread(char(pos_list(pos2_sim))));
subplot(4, 2, 5),imshow(imread(char(neg_imgs(1))));
subplot(4, 2, 6),imshow(imread(char(neg_imgs(neg1_sim))));
subplot(4, 2, 7),imshow(imread(char(neg_imgs(2))));
subplot(4, 2, 8),imshow(imread(char(neg_imgs(neg2_sim))));