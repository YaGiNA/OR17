function [ pcount, ncount ] = use_svg( dcnn_list )

dcnn_pos = dcnn_list(1:100, :);
dcnn_neg = dcnn_list(101:200, :);
 
training_label=[ones(100,1); ones(100,1)*(-1)] ;
data=[dcnn_pos; dcnn_neg];
 

data3=repmat(sqrt(abs(data)).*sign(data),[1 3]) .* ...
  [0.8*ones(size(data)) 0.6*cos(0.6*log(abs(data)+eps)) 0.6*sin(0.6*log(abs(data)+eps))];
 
training_data=data3;
 
testing_label=training_label;
testing_data=training_data;

model=fitcsvm(training_data, training_label,'KernelFunction','rbf', 'KernelScale','auto');
 
[plabel, score]=predict(model,testing_data);
 
pcount=numel(find((plabel .* testing_label)==1));
ncount=numel(find((plabel .* testing_label)==-1));
end

