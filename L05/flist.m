function list=flist()
 
  n=0; list={};
  % cat 以外をpositiveにする場合は，positiveにしたいクラスを先頭に持ってきましょう．
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
end