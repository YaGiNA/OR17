P1=imread('penguin1.jpg');
P2=imread('penguin2.jpg');
D =imread('dog.jpg');
RED_P1=P1(:,:,1); GREEN_P1=P1(:,:,2); BLUE_P1=P1(:,:,3);
P1_64=floor(double(RED_P1)/64) *4*4 + floor(double(GREEN_P1)/64) *4 + floor(double(BLUE_P1)/64);

P1_64_vec=reshape(P1_64,1,numel(P1_64));
h1=histc(P1_64_vec, [0:63]);