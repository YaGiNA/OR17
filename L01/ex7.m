n = 6;
m = 5;
a = rand([n, m]);

d = rand([1, m]);
d2=repmat(d,n,1);

b=(a-d2).^2;
c=sqrt(sum(b'));

[M,I] = min(c(:)) % I�̓��[�N���b�h�������ŏ��ƂȂ�C���f�b�N�X�ԍ�
%{
I =

     1
%}
