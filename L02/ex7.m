  n=0; list={};
  LIST={'cat' 'dog' 'elephant' 'fish' 'horse' 'lion' 'penguin' 'tiger' 'whale' 'wildcat'};
  DIR0='/usr/local/class/object/animal/';
  for i=1:length(LIST)
    DIR=strcat(DIR0,LIST(i),'/')
    W=dir(DIR{:});
    for j=1:size(W)
      if (strfind(W(j).name,'.jpg'))
          fn=strcat(DIR{:},W(j).name);
          n=n+1;
          list={list{:} fn};
      end
    end
  end
  
database=[];
for i=1:length(list)
    X=imread(list{i});
    RED_pic=X(:,:,1); GREEN_pic=X(:,:,2); BLUE_pic=X(:,:,3);
    pic_64=floor(double(RED_pic)/64) *4*4 + floor(double(GREEN_pic)/64) *4 + floor(double(BLUE_pic)/64);
    pic_64_vec=reshape(pic_64,1,numel(pic_64));
    h=histc(pic_64_vec, [0:63]);
    h=h/sum(h);
    database=[database; h];
end

save('db.mat','database');
load('db.mat');
N = 555;
query=database(N,:);
for i=1:size(database,1)
    sim=[sim sum(min(database(i,:),query))];
end
[sorted,index]=sort(sim,'descend');
subplot(1,4,1),imshow(imread(list{index(1)}));
subplot(1,4,2),imshow(imread(list{index(2)}));
subplot(1,4,3),imshow(imread(list{index(3)}));
subplot(1,4,4),imshow(imread(list{index(4)}));