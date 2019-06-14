close all;
clear all;

%% 绘制boat3
file1 = fopen("datas/adaptive//boat3.txt");
data = textscan(file1, '%f %f %f %f');
fclose(file1);
cfmaxresponse  = data{1};
cfconfidence = data{2};
pwpmaxresponse = data{3};
old_iou3 = data{4};

file2 = fopen("datas/adaptive/newiou3.txt");
new_iou = textscan(file2,"%f");
new_iou3 = new_iou{1};
fclose(file2);

% old_iou3 = old_iou3*100;
% new_iou3 = new_iou3*100;

% 截取一段
old_iou3 = old_iou3(700:end);
new_iou3 = new_iou3(700:end);

% 瞬时iou比较x
figure();
plot(new_iou3,'r','LineWidth',1);
hold on;
plot(old_iou3,'b','LineWidth',1);
legend('动态学习率','固定学习率');
xlabel("序列帧数");
ylabel("IoU/%");
title('某段序列固定与动态瞬时学习率对比');
% legend('hogr','hogconfidence','cnr','iou');

% success plot
thresh = 0:0.0001:1;
num3 = numel(old_iou3);
new_success_sum3 = zeros(1,numel(thresh));
old_suecess_sum3 = zeros(1,numel(thresh));
for i = 1:numel(thresh)
    old_sum = 0;
    new_sum = 0;
    for j = 1:num3
        if old_iou3(j) > thresh(i)
            old_sum = old_sum + 1;
        end
        if new_iou3(j) > thresh(i)
            new_sum = new_sum + 1;
        end
    end
    new_success_sum3(i)= new_sum;
    old_suecess_sum3(i)= old_sum;
end

% plot(thresh,old_suecess_sum3,'r');
% hold on;
% plot(thresh,new_success_sum3,'b');





%% 绘制boat4
file1 = fopen("datas/adaptive/boat4.txt");
data = textscan(file1, '%f %f %f %f');
fclose(file1);
cfmaxresponse  = data{1};
cfconfidence = data{2};
pwpmaxresponse = data{3};
old_iou4 = data{4};

file2 = fopen("datas/adaptive/newiou4.txt");
new_iou = textscan(file2,"%f");
new_iou4 = new_iou{1};
fclose(file2);

% old_iou4 = old_iou4*100;
% new_iou4 = new_iou4*100;

num4 = numel(old_iou4);
new_success_sum4 = zeros(1,numel(thresh));
old_suecess_sum4 = zeros(1,numel(thresh));
for i = 1:numel(thresh)
    old_sum = 0;
    new_sum = 0;
    for j = 1:num4
        if old_iou4(j) > thresh(i)
            old_sum = old_sum + 1;
        end
        if new_iou4(j) > thresh(i)
            new_sum = new_sum + 1;
        end
    end
    new_success_sum4(i)= new_sum;
    old_suecess_sum4(i)= old_sum;
end

% 
% % plot(data1);
% % hold on;
% % plot(data2);
% % hold on;
% % plot(data3);
% % hold on;
% figure();
% plot(old_iou4);
% hold on;
% plot(new_iou4);
% legend('adaptive','fixed');
% xlabel("sequence");
% ylabel("Intersection over Union(IoU)");
% % legend('hogr','hogconfidence','cnr','iou');
% 
%% 绘制boat5
file1 = fopen("datas/adaptive/boat5.txt");
data = textscan(file1, '%f %f %f %f');
fclose(file1);
cfmaxresponse  = data{1};
cfconfidence = data{2};
pwpmaxresponse = data{3};
old_iou5 = data{4};

file2 = fopen("datas/adaptive/newiou5.txt");
new_iou = textscan(file2,"%f");
new_iou5 = new_iou{1};
fclose(file2);


% old_iou5 = old_iou5*100;
% new_iou5 = new_iou5*100;

num5 = numel(old_iou5);
new_success_sum5 = zeros(1,numel(thresh));
old_suecess_sum5 = zeros(1,numel(thresh));
for i = 1:numel(thresh)
    old_sum = 0;
    new_sum = 0;
    for j = 1:num5
        if old_iou5(j) > thresh(i)
            old_sum = old_sum + 1;
        end
        if new_iou5(j) > thresh(i)
            new_sum = new_sum + 1;
        end
    end
    new_success_sum5(i)= new_sum;
    old_suecess_sum5(i)= old_sum;
end

old_total = (old_suecess_sum3+old_suecess_sum4+old_suecess_sum5)/(num3+num4+num5);
new_total = (new_success_sum3+new_success_sum4+new_success_sum5)/(num3+num4+num5);

old_aver = (sum(old_iou3,1)+sum(old_iou4,1)+sum(old_iou5,1))/(numel(old_iou3)+numel(old_iou4)+numel(old_iou5));
new_aver = (sum(new_iou3,1)+sum(new_iou4,1)+sum(new_iou5,1))/(numel(new_iou3)+numel(new_iou4)+numel(new_iou5));

% plot(thresh,new_total,'r','LineWidth',1);
% hold on;
% plot(thresh,old_total,'b','LineWidth',1);
% 
% xlabel('IoU阈值');
% ylabel('成功率');
% title('IoU阈值-成功率曲线');
% legend('动态学习率','固定学习率');


% 
% % plot(data1);
% % hold on;
% % plot(data2);
% % hold on;
% % plot(data3);
% % hold on;
% figure();
% plot(old_iou5);
% hold on;
% plot(new_iou5);
% legend('adaptive','fixed');
% xlabel("sequence");
% ylabel("Intersection over Union(IoU)");
% % legend('hogr','hogconfidence','cnr','iou');

