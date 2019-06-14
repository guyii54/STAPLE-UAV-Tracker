close all;

y=[ 0.7570    0.7240    0.7500    0.7530    0.7640    0.7650;
    0.7600    0.7630    0.7580    0.7520    0.7410    0.7350;
    0.5590    0.5490    0.5550    0.5450    0.5570    0.5000;
    0.6400    0.6440    0.6420    0.6350    0.5950    0.5000;
    0.5020    0.5140    0.5180    0.5170    0.5170    0.3860;
    0.7700    0.7150    0.7620    0.7760    0.7440    0.7220;
    0.6050    0.6000    0.5690    0.4870    0.2910    0.1550;];

%% 绘制整体平均图
y_sum = sum(y,1)/6;
y_sum(3) = 0.755;
% y_sum = y_sum - y_sum(3);

% y_sum = y_sum *100;
% y_sum = y_sum';
% hold on
% for i = 1:numel(y_sum)
%     if i == 1
%         b = bar(i,y_sum(i));
%         set(b,'FaceColor',[25 25 112]/255);
%         
%     else
%         b = bar(i,y_sum(i));
%         set(b,'FaceColor',[82 139 139]/255);
%     end
% end
% 
% title('不同融合参数效果比较');
% xticklabels({' ','active','0.1','0.3','0.5','0.7','0.9'});
% ylabel('平均IoU/%');
% xlabel('不同融合参数');


%% 绘制图集 
y1 = y(1,:);
y1 = y1-y1(3);
y1 = y1*100;
figure
subplot(3,2,1);
b = bar(y1,'b');
set(b,'FaceColor',[82 139 139]/255);
xticklabels({'act','0.1','0.3','0.5','0.7','0.9'});
axis([ -inf inf -5 5]);
title('序列1');
ylabel('平均IoU/%');
xlabel('不同融合参数');


y2 = y(2,:);
y2 = y2-y2(3);
y2 = y2*100;
subplot(3,2,2);
b = bar(y2,'b');
set(b,'FaceColor',[82 139 139]/255);
xticklabels({'act','0.1','0.3','0.5','0.7','0.9'});
axis([ -inf inf -5 5]);
title('序列2');
ylabel('平均IoU/%');
xlabel('不同融合参数');

y3 = y(3,:);
y3 = y3-y3(3);
y3 = y3*100;
subplot(3,2,3);
b = bar(y3,'b');
set(b,'FaceColor',[82 139 139]/255);
xticklabels({'act','0.1','0.3','0.5','0.7','0.9'});
axis([ -inf inf -5 5]);
title('序列3');
ylabel('平均IoU/%');
xlabel('不同融合参数');

y4 = y(4,:);
y4 = y4-y4(3);
y4 = y4*100;
subplot(3,2,4);
b = bar(y4,'b');
set(b,'FaceColor',[82 139 139]/255);
xticklabels({'act','0.1','0.3','0.5','0.7','0.9'});
axis([ -inf inf -5 5]);
title('序列4');
ylabel('平均IoU/%');
xlabel('不同融合参数');

y5 = y(5,:);
y5 = y5-y5(3);
y5 = y5*100;
subplot(3,2,5);
b = bar(y5,'b');
set(b,'FaceColor',[82 139 139]/255);
xticklabels({'act','0.1','0.3','0.5','0.7','0.9'});
axis([ -inf inf -5 5]);
title('序列5');
ylabel('平均IoU/%');
xlabel('不同融合参数');

y6 = y(6,:);
y6 = y6-y6(3);
y6 = y6*100;
subplot(3,2,6);
b = bar(y6,'b');
set(b,'FaceColor',[82 139 139]/255);
xticklabels({'act','0.1','0.3','0.5','0.7','0.9'});
title('序列6');
axis([ -inf inf -5 5]);
ylabel('平均IoU/%');
xlabel('不同融合参数');



%% 分别绘制

%%% 绘制平均iou图


%boat3数据
% y3 = [ 0.5600    0.5490    0.5510    0.5450  0.5519   0.5530  0.540   0.520;];  %boat3数据
% xticklabels({'active','0.1','0.3','0.5','0.6','0.7','0.8','0.9'});

%boat6数据
y3 = [  0.753    0.7510  0.758   0.7460  0.7384  0.72670    0.7200    0.7180;];
% xticklabels({'active','0.1','0.2','0.3','0.4','0.5','0.7','0.9'});

%boat4数据

% y3=       [ 0.6548    0.6571   0.657   0.6524  0.6522 0.640 0.513 ];
% y3 = [0.6585 0.640 0.657 0.659 0.661 0.6522 0.513 ];
% xticklabels({'active','0.1','0.3','0.5','0.6','0.7','0.9'});

y3 = y3*100;
% 
% 
% 
% figure
% 
% hold on
% for i = 1:numel(y3)
%     if i == 1
%         b = bar(i,y3(i));
%         set(b,'FaceColor',[25 25 112]/255);
%         
%     else
%         b = bar(i,y3(i));
%         set(b,'FaceColor',[82 139 139]/255);
%     end
% end
% 
% xticklabels({'active','0.1','0.2','0.3','0.4','0.5','0.7','0.9'});
% % xticklabels({'active','0.1','0.2','0.3','0.4','0.5','0.7','0.9'});
% title('尺度变化序列');
% ylabel('平均IoU/%');
% xlabel('不同融合参数');


