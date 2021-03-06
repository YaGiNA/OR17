n = 6;
m = 5;
a = rand([n, m]);
a1=repmat(a,n,1);
a2=reshape((ones(n,1)*reshape(a,1,n*m)),n*n,m);
tic
b=zeros([n, m]);
for i = 1:n*n
    for j = 1:m
    b(i, j) = (a1(i, j) - a2(i, j)) ^ 2;
    end
end
c=sqrt(sum(b'));
sim=reshape(c,n,n);
toc
tic
b=(a1-a2).^2;
c=sqrt(sum(b'));
sim=reshape(c,n,n);
toc
%{
実行例
sim =

  1 列から 8 列

         0    1.1794    1.2785    0.8763    1.0041    0.8728    0.8253    0.6053
    1.1794         0    1.0061    1.2422    0.7042    0.6437    0.6325    0.9596
    1.2785    1.0061         0    0.7758    0.8072    1.1272    0.8488    1.0181
    0.8763    1.2422    0.7758         0    0.9356    1.0601    0.6914    0.6851
    1.0041    0.7042    0.8072    0.9356         0    1.0283    0.5614    1.0165
    0.8728    0.6437    1.1272    1.0601    1.0283         0    0.6260    0.4819
    0.8253    0.6325    0.8488    0.6914    0.5614    0.6260         0    0.5837
    0.6053    0.9596    1.0181    0.6851    1.0165    0.4819    0.5837         0
    0.5097    0.7775    0.8256    0.6765    0.6587    0.6009    0.4629    0.4238
    0.8391    1.3655    0.9936    0.3319    1.0970    1.0845    0.7930    0.6443

  9 列から 10 列

    0.5097    0.8391
    0.7775    1.3655
    0.8256    0.9936
    0.6765    0.3319
    0.6587    1.0970
    0.6009    1.0845
    0.4629    0.7930
    0.4238    0.6443
         0    0.7360
    0.7360         0
経過時間は 0.001220 秒です。
経過時間は 0.000341 秒です。
%}
