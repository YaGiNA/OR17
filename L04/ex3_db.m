run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');
addpath('/usr/local/class/object/MATLAB/sift');
n=0; pos_list={}; neg_list={};
LIST={'cat' 'dog' 'elephant' 'fish' 'horse' 'lion' 'penguin' 'tiger' 'whale' 'wildcat'};
an_animal = 'wildcat';
DIR0='/usr/local/class/object/animal/';
for i=1:length(LIST)
  DIR=strcat(DIR0,LIST(i),'/');
  W=dir(DIR{:});
  if (contains(DIR, an_animal))
    for j=1:size(W)
      if (strfind(W(j).name,'.jpg'))
        fn=strcat(DIR{:},W(j).name);
        n=n+1;
        pos_list={pos_list{:} fn};
      end
    end
  else
    for j=1:size(W)
      if (strfind(W(j).name,'.jpg'))
        fn=strcat(DIR{:},W(j).name);
        n=n+1;
        neg_list={neg_list{:} fn};
      end
    end
  end
end
save('db_pos.mat','pos_list');
save('db_neg.mat','neg_list');

vec=[];
for i=1:length(pos_list)
    X=rgb2gray(imread(pos_list{i}));
    [pnt_pos,desc_pos] = sift_rand(X,'randn',300);
    vec = [vec desc_pos];
end
for i=1:length(neg_list)
    X=rgb2gray(imread(neg_list{i}));
    [pnt_neg,desc_neg] = sift_rand(X,'randn',300);
    vec = [vec desc_neg];
end
rp=randperm(size(vec, 2)); 
vec_use = vec(:, rp(1:50000));
[codebook,idx]=vl_kmeans(vec_use,500);
save('codebook.mat','codebook');

%{
実行例
codebook(128, 10)
  1 列から 8 列

    0.0564    0.0304    0.1577    0.0350    0.0875    0.1076    0.0305    0.0526
    0.0324    0.0116    0.1206    0.0446    0.0479    0.0814    0.0322    0.0357
    0.0326    0.0059    0.0447    0.0255    0.0471    0.0438    0.0258    0.0161
    0.0353    0.0497    0.0294    0.0335    0.0648    0.0392    0.0200    0.0128
    0.0286    0.2174    0.0192    0.0342    0.0510    0.0273    0.0126    0.0168
    0.0279    0.0342    0.0147    0.0199    0.0343    0.0133    0.0083    0.0109
    0.0480    0.0033    0.0135    0.0102    0.0447    0.0128    0.0053    0.0068
    0.0627    0.0067    0.0601    0.0091    0.0850    0.0421    0.0095    0.0127
    0.1432    0.2483    0.0591    0.2194    0.1837    0.2402    0.1939    0.2138
    0.0579    0.0545    0.0514    0.1792    0.1044    0.1497    0.0691    0.1520
    0.0186    0.0075    0.0628    0.0451    0.0387    0.0247    0.0200    0.0146
    0.0162    0.0168    0.1476    0.0243    0.0225    0.0082    0.0104    0.0037
    0.0236    0.0459    0.1320    0.0189    0.0150    0.0057    0.0045    0.0026
    0.0317    0.0059    0.0499    0.0099    0.0135    0.0040    0.0037    0.0025
    0.0568    0.0022    0.0187    0.0097    0.0323    0.0068    0.0061    0.0032
    0.1389    0.0391    0.0314    0.0543    0.1227    0.0612    0.0497    0.0226
    0.0561    0.2289    0.0728    0.2452    0.1302    0.2006    0.2378    0.2410
    0.0246    0.0377    0.0360    0.2344    0.0849    0.1073    0.0587    0.2004
    0.0282    0.0035    0.0414    0.1096    0.0367    0.0168    0.0090    0.0167
    0.0638    0.0044    0.0975    0.0780    0.0330    0.0079    0.0064    0.0069
    0.0783    0.0111    0.0852    0.0578    0.0430    0.0111    0.0073    0.0053
    0.0670    0.0090    0.0308    0.0250    0.0358    0.0145    0.0116    0.0040
    0.0690    0.0104    0.0240    0.0257    0.0363    0.0172    0.0231    0.0063
    0.0848    0.0478    0.0518    0.0890    0.0738    0.0530    0.1181    0.0227
    0.0430    0.0425    0.0888    0.0427    0.0460    0.0411    0.0472    0.1413
    0.0430    0.0139    0.0375    0.0643    0.0609    0.0334    0.0260    0.1168
    0.0558    0.0057    0.0238    0.1093    0.0409    0.0203    0.0202    0.0193
    0.0707    0.0120    0.0237    0.1817    0.0393    0.0203    0.0287    0.0094
    0.0527    0.0349    0.0330    0.1684    0.0701    0.0400    0.0418    0.0140
    0.0410    0.0214    0.0280    0.0766    0.0491    0.0410    0.0471    0.0173
    0.0432    0.0136    0.0325    0.0278    0.0284    0.0246    0.0398    0.0130
    0.0390    0.0187    0.0802    0.0207    0.0283    0.0248    0.0450    0.0306
    0.0869    0.0384    0.1274    0.0339    0.0798    0.1264    0.0388    0.0558
    0.0499    0.0089    0.1629    0.0243    0.0236    0.0339    0.0200    0.0271
    0.0444    0.0034    0.0930    0.0117    0.0194    0.0256    0.0172    0.0107
    0.0536    0.0577    0.0405    0.0212    0.0345    0.0348    0.0208    0.0143
    0.0535    0.2627    0.0188    0.0270    0.0610    0.0202    0.0159    0.0201
    0.0370    0.0474    0.0079    0.0217    0.0813    0.0181    0.0117    0.0167
    0.0369    0.0036    0.0076    0.0118    0.1254    0.0533    0.0081    0.0102
    0.0615    0.0082    0.0291    0.0118    0.1481    0.1414    0.0204    0.0206
    0.2185    0.2766    0.0601    0.2224    0.1669    0.2461    0.2519    0.2378
    0.1071    0.0484    0.0900    0.0986    0.0809    0.0862    0.0519    0.0917
    0.0320    0.0033    0.1320    0.0232    0.0492    0.0097    0.0100    0.0097
    0.0272    0.0145    0.1726    0.0142    0.0368    0.0084    0.0075    0.0040
    0.0341    0.0583    0.0868    0.0119    0.0380    0.0064    0.0043    0.0057
    0.0215    0.0109    0.0130    0.0173    0.0362    0.0101    0.0028    0.0057
    0.0271    0.0031    0.0069    0.0188    0.0697    0.0364    0.0044    0.0057
    0.1025    0.0371    0.0143    0.0787    0.1255    0.1575    0.0738    0.0486
    0.0644    0.2642    0.1930    0.2525    0.1817    0.2398    0.2687    0.2625
    0.0291    0.0436    0.0477    0.1968    0.0973    0.1277    0.0813    0.1552
    0.0449    0.0047    0.0316    0.1111    0.0406    0.0182    0.0205    0.0109
    0.1289    0.0062    0.0586    0.0951    0.0357    0.0086    0.0126    0.0059
    0.1695    0.0114    0.0381    0.0515    0.0475    0.0087    0.0063    0.0048
    0.1055    0.0075    0.0209    0.0153    0.0347    0.0101    0.0070    0.0027
    0.0448    0.0057    0.0318    0.0100    0.0316    0.0100    0.0134    0.0053
    0.0417    0.0389    0.1047    0.0633    0.0747    0.0526    0.1028    0.0486
    0.0502    0.0500    0.1229    0.0491    0.0633    0.0614    0.0502    0.2103
    0.0607    0.0189    0.0254    0.0606    0.0496    0.0485    0.0378    0.1374
    0.0747    0.0097    0.0130    0.1105    0.0328    0.0295    0.0541    0.0166
    0.0966    0.0195    0.0225    0.1760    0.0479    0.0251    0.0842    0.0074
    0.0795    0.0421    0.0322    0.1285    0.0989    0.0387    0.0600    0.0108
    0.0564    0.0178    0.0458    0.0398    0.0719    0.0332    0.0412    0.0071
    0.0456    0.0102    0.0645    0.0206    0.0472    0.0207    0.0314    0.0067
    0.0430    0.0183    0.1158    0.0245    0.0379    0.0278    0.0317    0.0445
    0.0793    0.0387    0.0687    0.0148    0.0514    0.1175    0.0360    0.0605
    0.0401    0.0087    0.0963    0.0060    0.0415    0.0178    0.0180    0.0215
    0.0393    0.0034    0.0643    0.0070    0.0598    0.0068    0.0111    0.0099
    0.0527    0.0556    0.0336    0.0065    0.0967    0.0075    0.0113    0.0124
    0.0577    0.2597    0.0227    0.0122    0.0927    0.0091    0.0165    0.0165
    0.0423    0.0430    0.0198    0.0087    0.0600    0.0212    0.0144    0.0131
    0.0425    0.0036    0.0182    0.0071    0.0583    0.0852    0.0164    0.0087
    0.0607    0.0086    0.0353    0.0090    0.0624    0.2071    0.0260    0.0240
    0.2216    0.2761    0.1090    0.0986    0.1633    0.1815    0.2384    0.2435
    0.1091    0.0401    0.0843    0.0267    0.0953    0.0407    0.1131    0.0491
    0.0263    0.0025    0.0844    0.0141    0.0727    0.0116    0.0204    0.0046
    0.0235    0.0099    0.0740    0.0056    0.0825    0.0106    0.0065    0.0035
    0.0213    0.0560    0.0420    0.0041    0.0586    0.0142    0.0050    0.0051
    0.0176    0.0144    0.0159    0.0052    0.0304    0.0252    0.0041    0.0061
    0.0265    0.0043    0.0146    0.0086    0.0318    0.0720    0.0083    0.0064
    0.1017    0.0468    0.0340    0.0341    0.0678    0.1771    0.0545    0.0698
    0.0946    0.2628    0.2323    0.1289    0.2025    0.2167    0.2261    0.2614
    0.0494    0.0418    0.0773    0.0632    0.0890    0.1044    0.2184    0.0765
    0.0295    0.0068    0.0218    0.0674    0.0303    0.0250    0.1713    0.0056
    0.0448    0.0069    0.0185    0.0568    0.0321    0.0097    0.0484    0.0041
    0.1211    0.0109    0.0172    0.0311    0.0423    0.0079    0.0051    0.0063
    0.1730    0.0064    0.0108    0.0114    0.0263    0.0090    0.0020    0.0088
    0.0941    0.0049    0.0163    0.0119    0.0226    0.0179    0.0029    0.0125
    0.0531    0.0430    0.0989    0.0350    0.0959    0.0757    0.0283    0.0893
    0.0285    0.0482    0.1540    0.0445    0.0650    0.0705    0.0213    0.2027
    0.0243    0.0175    0.0446    0.0346    0.0417    0.0593    0.0690    0.0995
    0.0273    0.0110    0.0224    0.0603    0.0333    0.0339    0.2178    0.0174
    0.0378    0.0237    0.0284    0.0934    0.0609    0.0271    0.1731    0.0092
    0.0820    0.0467    0.0322    0.0656    0.1083    0.0331    0.0360    0.0124
    0.1434    0.0133    0.0388    0.0292    0.0571    0.0211    0.0107    0.0095
    0.1134    0.0097    0.0468    0.0180    0.0311    0.0175    0.0067    0.0088
    0.0512    0.0209    0.1061    0.0239    0.0441    0.0335    0.0052    0.0565
    0.0461    0.0310    0.0374    0.0072    0.0423    0.0962    0.0210    0.0485
    0.0314    0.0078    0.0428    0.0040    0.0357    0.0309    0.0155    0.0202
    0.0283    0.0042    0.0321    0.0027    0.0376    0.0125    0.0087    0.0082
    0.0266    0.0415    0.0230    0.0021    0.0777    0.0074    0.0094    0.0081
    0.0350    0.2141    0.0267    0.0051    0.0853    0.0098    0.0131    0.0121
    0.0476    0.0387    0.0302    0.0055    0.0496    0.0221    0.0155    0.0129
    0.0522    0.0055    0.0292    0.0060    0.0384    0.0641    0.0222    0.0091
    0.0511    0.0094    0.0353    0.0053    0.0369    0.1196    0.0179    0.0208
    0.1414    0.2504    0.0956    0.0145    0.1452    0.0846    0.0650    0.1911
    0.1148    0.0394    0.0624    0.0072    0.0638    0.0369    0.0848    0.0702
    0.0630    0.0035    0.0348    0.0052    0.0308    0.0199    0.0430    0.0078
    0.0301    0.0071    0.0284    0.0043    0.0428    0.0194    0.0170    0.0039
    0.0193    0.0388    0.0259    0.0036    0.0394    0.0271    0.0093    0.0047
    0.0214    0.0122    0.0239    0.0038    0.0327    0.0282    0.0114    0.0054
    0.0248    0.0071    0.0300    0.0046    0.0459    0.0594    0.0173    0.0078
    0.0725    0.0539    0.0494    0.0109    0.0871    0.1034    0.0217    0.0415
    0.0751    0.2295    0.2113    0.0197    0.1556    0.1211    0.0403    0.2399
    0.1225    0.0490    0.0964    0.0153    0.0838    0.0629    0.1503    0.1203
    0.1160    0.0082    0.0223    0.0164    0.0494    0.0219    0.1958    0.0111
    0.0672    0.0067    0.0135    0.0153    0.0441    0.0135    0.0471    0.0042
    0.0412    0.0096    0.0141    0.0090    0.0273    0.0147    0.0091    0.0064
    0.0510    0.0049    0.0082    0.0058    0.0147    0.0138    0.0045    0.0083
    0.0269    0.0036    0.0154    0.0079    0.0187    0.0311    0.0091    0.0075
    0.0308    0.0397    0.0857    0.0093    0.0709    0.0841    0.0085    0.0488
    0.0210    0.0410    0.1289    0.0182    0.0478    0.0578    0.0245    0.1562
    0.0327    0.0171    0.0704    0.0181    0.0416    0.0466    0.0623    0.0870
    0.0668    0.0095    0.0442    0.0181    0.0454    0.0255    0.1888    0.0169
    0.0749    0.0248    0.0446    0.0194    0.0726    0.0334    0.0945    0.0084
    0.0614    0.0414    0.0316    0.0125    0.0651    0.0325    0.0117    0.0145
    0.0730    0.0112    0.0173    0.0093    0.0314    0.0154    0.0066    0.0133
    0.0473    0.0078    0.0169    0.0102    0.0217    0.0171    0.0098    0.0091
    0.0241    0.0162    0.0663    0.0119    0.0373    0.0362    0.0134    0.0373

  9 列から 10 列

    0.0342    0.0525
    0.0250    0.0432
    0.0232    0.0278
    0.0347    0.0294
    0.0390    0.0789
    0.0178    0.0913
    0.0237    0.0229
    0.0434    0.0296
    0.0352    0.1282
    0.0324    0.1094
    0.0354    0.0456
    0.0484    0.0268
    0.0513    0.0504
    0.0327    0.0428
    0.0270    0.0167
    0.0329    0.0279
    0.1420    0.1368
    0.0476    0.0885
    0.0284    0.0309
    0.0311    0.0200
    0.0278    0.0259
    0.0171    0.0279
    0.0254    0.0292
    0.1184    0.0485
    0.1334    0.0514
    0.0293    0.0438
    0.0137    0.0278
    0.0312    0.0226
    0.0479    0.0338
    0.0228    0.0337
    0.0367    0.0341
    0.1361    0.0390
    0.0268    0.1008
    0.0213    0.0775
    0.0300    0.0195
    0.0443    0.0179
    0.0479    0.0881
    0.0337    0.1314
    0.0306    0.0489
    0.0388    0.0450
    0.0502    0.1669
    0.0400    0.0505
    0.0475    0.0165
    0.0717    0.0182
    0.0514    0.0878
    0.0309    0.1473
    0.0284    0.0580
    0.0302    0.0622
    0.2404    0.2102
    0.0644    0.0781
    0.0211    0.0223
    0.0223    0.0147
    0.0169    0.0248
    0.0133    0.0380
    0.0263    0.0401
    0.1360    0.0862
    0.1666    0.0661
    0.0282    0.0498
    0.0202    0.0317
    0.1081    0.0333
    0.1346    0.0516
    0.0270    0.0493
    0.0218    0.0384
    0.1047    0.0437
    0.0231    0.1876
    0.0174    0.1471
    0.0308    0.0174
    0.0685    0.0090
    0.0716    0.0417
    0.0358    0.0764
    0.0243    0.0344
    0.0282    0.0515
    0.0803    0.1152
    0.0414    0.0504
    0.0430    0.0112
    0.0873    0.0206
    0.0690    0.1190
    0.0332    0.1865
    0.0204    0.0718
    0.0327    0.0431
    0.2574    0.1784
    0.0864    0.1244
    0.0199    0.0454
    0.0281    0.0276
    0.0225    0.0472
    0.0131    0.0493
    0.0162    0.0274
    0.1072    0.0450
    0.1370    0.0679
    0.0314    0.0781
    0.0224    0.0463
    0.1933    0.0457
    0.2052    0.0658
    0.0193    0.0417
    0.0086    0.0217
    0.0367    0.0251
    0.0243    0.1808
    0.0158    0.1518
    0.0268    0.0182
    0.0521    0.0094
    0.0664    0.0173
    0.0330    0.0204
    0.0253    0.0139
    0.0299    0.0311
    0.0787    0.0805
    0.0226    0.0860
    0.0233    0.0324
    0.0494    0.0480
    0.0538    0.1152
    0.0343    0.0929
    0.0452    0.0205
    0.0807    0.0167
    0.2065    0.0872
    0.0590    0.1036
    0.0237    0.0438
    0.0462    0.0423
    0.0360    0.0775
    0.0145    0.0579
    0.0242    0.0210
    0.1307    0.0226
    0.0503    0.0776
    0.0228    0.0786
    0.0263    0.0418
    0.1632    0.0320
    0.1864    0.0423
    0.0237    0.0269
    0.0081    0.0151
    0.0216    0.0259

%}