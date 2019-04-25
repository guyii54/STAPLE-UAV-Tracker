close all;


%%
file1 = fopen("boat3.txt");
data = textscan(file1, '%f %f %f %f');
fclose(file1);
cfmaxresponse  = data{1};
cfconfidence = data{2};
pwpmaxresponse = data{3};
old_iou3 = data{4};

file2 = fopen("newiou.txt");
new_iou = textscan(file2,"%f");
new_iou3 = new_iou{1};
fclose(file2);

% plot(data1);
% hold on;
% plot(data2);
% hold on;
% plot(data3);
% hold on;
figure();
plot(old_iou3);
hold on;
plot(new_iou3);
legend('adaptive','fixed');
xlabel("sequence");
ylabel("Intersection over Union(IoU)");
% legend('hogr','hogconfidence','cnr','iou');

%%
file1 = fopen("boat4.txt");
data = textscan(file1, '%f %f %f %f');
fclose(file1);
cfmaxresponse  = data{1};
cfconfidence = data{2};
pwpmaxresponse = data{3};
old_iou4 = data{4};

file2 = fopen("newiou4.txt");
new_iou = textscan(file2,"%f");
new_iou4 = new_iou{1};
fclose(file2);

% plot(data1);
% hold on;
% plot(data2);
% hold on;
% plot(data3);
% hold on;
figure();
plot(old_iou4);
hold on;
plot(new_iou4);
legend('adaptive','fixed');
xlabel("sequence");
ylabel("Intersection over Union(IoU)");
% legend('hogr','hogconfidence','cnr','iou');

%%
file1 = fopen("boat5.txt");
data = textscan(file1, '%f %f %f %f');
fclose(file1);
cfmaxresponse  = data{1};
cfconfidence = data{2};
pwpmaxresponse = data{3};
old_iou5 = data{4};

file2 = fopen("newiou5.txt");
new_iou = textscan(file2,"%f");
new_iou5 = new_iou{1};
fclose(file2);

% plot(data1);
% hold on;
% plot(data2);
% hold on;
% plot(data3);
% hold on;
figure();
plot(old_iou5);
hold on;
plot(new_iou5);
legend('adaptive','fixed');
xlabel("sequence");
ylabel("Intersection over Union(IoU)");
% legend('hogr','hogconfidence','cnr','iou');

