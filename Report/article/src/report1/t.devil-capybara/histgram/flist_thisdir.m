function list_thisdir=flist_thisdir()
  % 現在dir以下が持つ画像パスのリストを作成する
  n=0; list_thisdir={};
  LIST={'imgdir-t.devil', 'imgdir-capybara'};
  DIR0='../';
  % DIR0は適宜変更の必要有: 末尾は/imgdirとすること
  for i=1:length(LIST)
    DIR=strcat(DIR0,LIST(i),'/');
    W=dir(DIR{:});
    for j=1:size(W)
      if (strfind(W(j).name,'.jpg'))
        fn=strcat(DIR{:},W(j).name);
        n=n+1;
        list_thisdir={list_thisdir{:} fn};
      end
    end
  end
end