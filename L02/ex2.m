X=webread('http://mm.cs.uec.ac.jp/lion.jpg');
GRAY2 = rgb2gray(X);
f=[1 1 1; 1 1 1; 1 1 1] / 9;
I2=uint8(filter2(f,GRAY2,'same'));
I5=GRAY2;
for i=1:5
    I5 = uint8(filter2(f,I5,'same'));
end
I10=GRAY2;
for i=1:10
    I10 = uint8(filter2(f,I10,'same'));
end

f2=[1 1 1; 1 -8 1; 1 1 1];
f3=[-1 -2 -1; 0 0 0; 1 2 1];
f4=[-1 0 1; -2 0 2; -1 0 1];
I_l=uint8(filter2(f2,GRAY2,'same'));
I_s1= abs(filter2(f3,GRAY2,'same'));
I_s2= abs(filter2(f4,GRAY2,'same'));
I_s = uint8(hypot(I_s1, I_s2));

f5=[-2 -1 -2; 0 0 0; 2 1 2];
f6=[-2 0 2; -1 0 1; -2 0 2];
I_s_tilt1= abs(filter2(f3,GRAY2,'same'));
I_s_tilt2= abs(filter2(f4,GRAY2,'same'));
I_s_tilt = uint8(hypot(I_s_tilt1, I_s_tilt2));

subplot(2,3,1),imshow(I2);
subplot(2,3,2),imshow(I5);
subplot(2,3,3),imshow(I10);
subplot(2,3,4),imshow(I_l);
subplot(2,3,5),imshow(I_s);
subplot(2,3,6),imshow(I_s_tilt);