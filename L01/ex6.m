n = 6;
m = 5;
a = rand([n, m]);
a1=repmat(a,n,1);

d = rand([1, m]);

e = zeros([n, m]);
for i = 1:n
    for j = 1:m
    e(i, j) = (a1(i, j) - d2(i, j)) ^ 2;
    end
end
c=sqrt(sum(e'));
[M,I] = min(c(:)) % Iはユークリッド距離が最小となるインデックス番号
%{
I =

     3
%}
