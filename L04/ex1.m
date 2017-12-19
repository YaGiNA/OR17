run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');
n=0; list={};
LIST={'cat' 'dog' 'elephant' 'fish' 'horse' 'lion' 'penguin' 'tiger' 'whale' 'wildcat'};
DIR0='/usr/local/class/object/animal/';
for i=1:length(LIST)
  DIR=strcat(DIR0,LIST(i),'/');
  W=dir(DIR{:});
  for j=1:size(W)
    if (strfind(W(j).name,'.jpg'))
        fn=strcat(DIR{:},W(j).name);
        n=n+1;
        list={list{:} fn};
    end
  end
end


load('db.mat');
sel=randperm(1000,100); 
rand_imgs=database(sel,:);
rand_list=list(sel);
[C2, IDX2] = vl_kmeans(rand_imgs', 5);
group1 = find( IDX2 == 1 );
size1 = size(group1, 2);
if size1 > 10
    size1 = 10;
end
group2 = find( IDX2 == 2 );
size2 = size(group2, 2);
if size2 > 10
    size2 = 10;
end
group3 = find( IDX2 == 3 );
size3 = size(group3, 2);
if size3 > 10
    size3 = 10;
end
group4 = find( IDX2 == 4 );
size4 = size(group4, 2);
if size4 > 10
    size4 = 10;
end
group5 = find( IDX2 == 5 );
size5 = size(group5, 2);
if size5 > 10
    size5 = 10;
end
for i = 1:size1
    subplot(5, 10, i),imshow(imread(char(rand_list(group1(i)))));
end
for i = 1:size2
    subplot(5, 10, 10+i),imshow(imread(char(rand_list(group2(i)))));
end
for i = 1:size3
    subplot(5, 10, 20+i),imshow(imread(char(rand_list(group3(i)))));
end
for i = 1:size4
    subplot(5, 10, 30+1),imshow(imread(char(rand_list(group4(i)))));
end
for i = 1:size5
    subplot(5, 10, 40+i),imshow(imread(char(rand_list(group5(i)))));
end