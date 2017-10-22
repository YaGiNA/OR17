n = 6;
m = 5;
a = rand([n, m]);

d = rand([1, m]);
d2=repmat(d,n,1);

b=(a-d2).^2;
c=sqrt(sum(b'));

[M,I] = min(c(:)) % Iはユークリッド距離が最小となるインデックス番号
%{
I =

     1
%}
