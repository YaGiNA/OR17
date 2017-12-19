run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');
addpath('/usr/local/class/object/MATLAB/sift');
n=0; pos_list={}; neg_list={};
LIST={'cat' 'dog' 'elephant' 'fish' 'horse' 'lion' 'penguin' 'tiger' 'whale' 'wildcat'};
an_animal = 'wildcat';
DIR0='/usr/local/class/object/animal/';
for i=1:length(LIST)
  DIR=strcat(DIR0,LIST(i),'/');
  W=dir(DIR{:});
  if (contains(DIR, an_animal))
    for j=1:size(W)
      if (strfind(W(j).name,'.jpg'))
        fn=strcat(DIR{:},W(j).name);
        n=n+1;
        pos_list={pos_list{:} fn};
      end
    end
  else
    for j=1:size(W)
      if (strfind(W(j).name,'.jpg'))
        fn=strcat(DIR{:},W(j).name);
        n=n+1;
        neg_list={neg_list{:} fn};
      end
    end
  end
end

database_pos=[];
for i=1:length(pos_list)
    X=imread(pos_list{i});
    RED_pic=X(:,:,1); GREEN_pic=X(:,:,2); BLUE_pic=X(:,:,3);
    pic_64=floor(double(RED_pic)/64) *4*4 + floor(double(GREEN_pic)/64) *4 + floor(double(BLUE_pic)/64);
    pic_64_vec=reshape(pic_64,1,numel(pic_64));
    h=histc(pic_64_vec, [0:63]);
    h=h/sum(h);
    database_pos=[database_pos; h];
end
save('db_pos.mat','database_pos');
database_neg=[];
for i=1:length(neg_list)
    X=imread(neg_list{i});
    RED_pic=X(:,:,1); GREEN_pic=X(:,:,2); BLUE_pic=X(:,:,3);
    pic_64=floor(double(RED_pic)/64) *4*4 + floor(double(GREEN_pic)/64) *4 + floor(double(BLUE_pic)/64);
    pic_64_vec=reshape(pic_64,1,numel(pic_64));
    h=histc(pic_64_vec, [0:63]);
    h=h/sum(h);
    database_neg=[database_neg; h];
end
save('db_neg.mat','database_neg');
