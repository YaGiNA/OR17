run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');
addpath('/usr/local/class/object/MATLAB/sift');
load('db_pos.mat');
rand_pos_imgs=database_pos(1:100,:);

load('db_neg.mat');
sel=randperm(900,100);
rand_neg_imgs=database_neg(sel,:);
vec=[];
for i = 1:100
    I_pos = rand_pos_imgs(i, :);
    [pnt_pos,desc_pos] = sift_rand(I_pos,'randn',300);
    
end
% [codebook,idx]=vl_kmeans(vec,500);
% save('codebook.mat','codebook');