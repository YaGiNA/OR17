load('db_pos.mat');
rand_pos_imgs=database_pos(1:100,:);

load('db_neg.mat');
sel=randperm(900,100);
rand_neg_imgs=database_neg(sel,:);
rand_neg_list=neg_list(sel);

for i = 1:100
    
end