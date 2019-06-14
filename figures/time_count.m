close all;

file1 = fopen("datas/boat1.txt");
data = textscan(file1, '%f %f %f %f %f %f %f %f %f');
fclose(file1);
update = data{3};
train = data{4};
u_hog = data{5};
u_cn = data{6};
u_sc = data{7};
t_hog = data{8};
t_sc = data{9};

a_update = sum(update,1)/numel(update);
a_train = sum(train,1)/numel(train);
a_u_hog = sum(u_hog)/numel(u_hog);
a_u_cn = sum(u_cn)/numel(u_cn);
a_u_sc = sum(u_sc)/numel(u_sc);
a_t_hog = sum(t_hog)/numel(t_hog);
a_t_sc = sum(t_sc)/numel(t_sc);