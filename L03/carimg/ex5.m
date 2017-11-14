addpath('/usr/local/class/object/MATLAB/sift');
IMGs = {'estima1.jpg' 'estima3.jpg'  'land2.jpg'  'prius1.jpg' 'prius3.jpg' 'estima2.jpg'  'land1.jpg' 'land3.jpg' 'prius2.jpg'};
y = size(IMGs);
simmilars = zeros(y(2));
for i = 1:y(2)
    I1=im2double(rgb2gray(imread(IMGs{i})));
    [pnt1,desc1]=sift(I1);
    sim1=size(pnt1, 2);
    for j = 1:y(2)
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

    1.0000    0.0386    0.0758    0.0622    0.0483    0.1221    0.0478    0.0603    0.0994
    0.0257    1.0000    0.0398    0.0298    0.0339    0.0506    0.0214    0.0487    0.0705
    0.0723    0.0522    1.0000    0.0725    0.0525    0.0828    0.0628    0.0659    0.1822
    0.0432    0.0291    0.0612    1.0000    0.0404    0.0677    0.0395    0.0488    0.0883
    0.0248    0.0345    0.0446    0.0481    1.0000    0.0639    0.0351    0.0395    0.0931
    0.0707    0.0361    0.0696    0.0434    0.0432    1.0000    0.0574    0.0612    0.1289
    0.0314    0.0257    0.0526    0.0371    0.0330    0.0534    1.0000    0.0470    0.0649
    0.0432    0.0322    0.0556    0.0576    0.0358    0.0623    0.0601    1.0000    0.1265
    0.0346    0.0164    0.0478    0.0194    0.0461    0.0536    0.0271    0.0286    1.0000
%}