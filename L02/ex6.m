P1=imread('penguin1.jpg');
P2=imread('penguin2.jpg');
D =imread('dog.jpg');
RED_P1=P1(:,:,1); GREEN_P1=P1(:,:,2); BLUE_P1=P1(:,:,3);
RED_P2=P2(:,:,1); GREEN_P2=P2(:,:,2); BLUE_P2=P2(:,:,3);
RED_D=D(:,:,1); GREEN_D=D(:,:,2); BLUE_D=D(:,:,3);

P1_64=floor(double(RED_P1)/64) *4*4 + floor(double(GREEN_P1)/64) *4 + floor(double(BLUE_P1)/64);
P2_64=floor(double(RED_P2)/64) *4*4 + floor(double(GREEN_P2)/64) *4 + floor(double(BLUE_P2)/64);
D_64=floor(double(RED_D)/64) *4*4 + floor(double(GREEN_D)/64) *4 + floor(double(BLUE_D)/64);

P1_64_vec=reshape(P1_64,1,numel(P1_64));
P2_64_vec=reshape(P2_64,1,numel(P2_64));
D_64_vec=reshape(D_64,1,numel(D_64));

h1=histc(P1_64_vec, [0:63]);
h2=histc(P2_64_vec, [0:63]);
d=histc(D_64_vec, [0:63]);

h1=h1 / sum(h1);
h2=h2 / sum(h2);
d=d / sum(d);
sim_P=sum(min(h1,h2)) % ÉyÉìÉMÉììØém
sim_PD=sum(min(h1,d)) % ÉyÉìÉMÉìÇ∆å¢

%{
é¿çsó·
sim_P =

    0.7821


sim_PD =

    0.4623
%}