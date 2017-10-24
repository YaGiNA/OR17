X=webread('http://mm.cs.uec.ac.jp/lion.jpg');
RED=X(:,:,1); GREEN=X(:,:,2); BLUE=X(:,:,3);
X64=floor(double(RED)/64) *4*4 + floor(double(GREEN)/64) *4 + floor(double(BLUE)/64);
[n, m]=size(X64);
hist = zeros(1, 64);
for i=1:n
    for j=1:m
        val=X64(i,j) + 1;
        hist(1, val) = hist(1, val) + 1;
    end
end
subplot(1,3,1),bar(hist)

X64_vec=reshape(X64,1,numel(X64));
h=histc(X64_vec,[0:63]);
subplot(1,3,2),bar(h);

subplot(1,3,3),histogram(X64);