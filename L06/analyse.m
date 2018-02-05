function [ dcnn_list ] = analyse( net, isdeeper)
%UNTITLED8 この関数の概要をここに記述
%   詳細説明をここに記述
    load('filelist.mat');
    net = load(net)
    dcnn_list=[];
    for i = 1:200
        im = imread(list{i}) ;
        im_ = single(im) ; % note: 0-255 range
        im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
        if isdeeper == false
            im_ = im_ - net.meta.normalization.averageImage ;
        else
            im_ = im_ - repmat(net.meta.normalization.averageImage,net.meta.normalization.imageSize(1:2));
        end
        res = vl_simplenn(net, im_);

        dcnnf=squeeze(res(end-3).x);
        dcnnf=dcnnf/norm(dcnnf);
        dcnn_list = [dcnn_list dcnnf];
    end
end

