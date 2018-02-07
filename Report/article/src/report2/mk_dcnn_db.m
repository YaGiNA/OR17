list_others = flist_others();
list_thisdir = flist_thisdir();
list = [list_thisdir(1:25) list_others];
dcnn_train = mk_dcnnlist(list);
save('dcnn_train.mat', 'dcnn_train');