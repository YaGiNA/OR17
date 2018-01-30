run('/usr/local/class/object/MATLAB/vlfeat/vl_setup');
addpath('/usr/local/class/object/MATLAB/sift');
load('code.mat');
bof_pos = code(1:100, :);
bof_neg = code(101:200, :);
 
training_label=[ones(100,1); ones(100,1)*(-1)] ;
data=[bof_pos; bof_neg];
 

data3=repmat(sqrt(abs(data)).*sign(data),[1 3]) .* ...
  [0.8*ones(size(data)) 0.6*cos(0.6*log(abs(data)+eps)) 0.6*sin(0.6*log(abs(data)+eps))];
 
training_data=data3;
 
testing_label=training_label;
testing_data=training_data;
tic;
model=fitcsvm(training_data, training_label,'KernelFunction','rbf', 'KernelScale','auto');
 
[plabel,score]=predict(model,testing_data);
toc;
 
pcount=numel(find((plabel .* testing_label)==1));
ncount=numel(find((plabel .* testing_label)==-1));

fprintf('classification rate: %.5f\n',pcount/(pcount+ncount));

tic;
model=fitcsvm(training_data, training_label,'KernelFunction','linear', 'KernelScale','auto');
 
[plabel,score]=predict(model,testing_data);
toc;
 
pcount=numel(find((plabel .* testing_label)==1));
ncount=numel(find((plabel .* testing_label)==-1));

fprintf('classification rate: %.5f\n',pcount/(pcount+ncount));

%{
実行例
経過時間は 0.097280 秒です。
classification rate: 0.99500
経過時間は 0.090838 秒です。
classification rate: 0.83000
%}