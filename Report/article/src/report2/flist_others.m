function list_others=flist_others()
 
  n=0; list_others={};
  % cat 以外をpositiveにする場合は，positiveにしたいクラスを先頭に持ってきましょう．
  LIST={'cat' 'dog' 'elephant' 'fish' 'horse' 'lion' 'penguin' 'tiger', 'wildcat'};
  % t.devil/それいがいのリスト作成用
  DIR0='/usr/local/class/object/animal/';
  for i=1:length(LIST)
    DIR=strcat(DIR0,LIST(i),'/')
    W=dir(DIR{:});
    for j=1:size(W)
      if (strfind(W(j).name,'.jpg'))
        fn=strcat(DIR{:},W(j).name);
        n=n+1;
        list_others={list_others{:} fn};
      end
    end
  end
end