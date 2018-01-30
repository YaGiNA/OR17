run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');
addpath('/usr/local/class/object/MATLAB/sift');
load('code.mat');
bof_pos = code(1:100, :);
bof_neg = code(101:200, :);

training_label=[ones(100,1); ones(100,1)*(-1)] ;
training_data=[bof_pos; bof_neg];
 
testing_label=training_label;
testing_data=training_data;
 
tic;
model=fitcsvm(training_data, training_label,'KernelFunction','rbf','KernelScale','auto');
 
[plabel,score]=predict(model,testing_data);
toc;
 
pcount=numel(find((plabel .* testing_label)==1));
ncount=numel(find((plabel .* testing_label)==-1));
 
fprintf('classification rate: %.5f\n',pcount/(pcount+ncount));

tic;
model=fitcsvm(training_data, training_label,'KernelFunction','linear','KernelScale','auto');
 
[plabel,score]=predict(model,testing_data);
toc;
 
pcount=numel(find((plabel .* testing_label)==1));
ncount=numel(find((plabel .* testing_label)==-1));
 
fprintf('classification rate: %.5f\n',pcount/(pcount+ncount));

%{
実行例
経過時間は 0.057983 秒です。
classification rate: 0.99000
経過時間は 0.056822 秒です。
classification rate: 0.82500
%}