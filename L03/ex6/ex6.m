I1=imresize(im2double(rgb2gray(imread('suzuka-wheel1.jpg'))), 0.4);
IMGs = {'atandt1.jpg' 'atandt2.jpg'  'atandt3.jpg'  'empire1.jpg' 'empire2.jpg' 'empire3.jpg'  'suzuka-wheel1.jpg' 'suzuka-wheel2.jpg' 'suzuka-wheel3.jpg'};
y = size(IMGs, 2);
simmilars = zeros(y);
for i = 1:y
    I1=im2double(rgb2gray(imread(IMGs{i})));
    [pnt1,desc1]=sift(I1);
    sim1=size(pnt1, 2);
    for j = 1:y
        if i == j
            simmilars(i, j) = 1;
            continue
        end
        I2=im2double(rgb2gray(imread(IMGs{j})));
        [pnt2,desc2]=sift(I2);
        sim2 = size(pnt2, 2);
        sim = size(siftmatch(desc1, desc2));
        simmilars(i, j) = sim(2) / ((sim1 + sim2) / 2);
    end
end

%{
実行例
simmilars =

    1.0000    0.0266    0.0204    0.0284    0.0430    0.0363    0.0297    0.0207    0.0257
    0.0714    1.0000    0.0533    0.0506    0.0593    0.0454    0.0399    0.0422    0.0386
    0.0754    0.0520    1.0000    0.0398    0.0602    0.0440    0.0449    0.0308    0.0522
    0.0750    0.0531    0.0722    1.0000    0.0842    0.0599    0.0648    0.0625    0.0633
    0.0820    0.0593    0.0573    0.0528    1.0000    0.0469    0.0547    0.0528    0.0583
    0.0968    0.0290    0.0470    0.0438    0.0569    1.0000    0.0574    0.0428    0.0711
    0.0752    0.0486    0.0449    0.0562    0.0660    0.0689    1.0000    0.0471    0.0748
    0.0702    0.0508    0.0455    0.0601    0.0659    0.0391    0.0677    1.0000    0.1240
    0.0631    0.0276    0.0244    0.0406    0.0457    0.0436    0.0461    0.0760    1.0000
%}