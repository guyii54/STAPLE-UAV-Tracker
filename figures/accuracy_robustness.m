close all;

% %% accuracy
thresh = 0:0.0001:1;

kcf_acc = zeros(1,numel(thresh));
for i = 1:numel(thresh)
    sum = 0;
    for j = 1:numel(iou_kcf)
        if iou_kcf(j) > thresh(i)
            sum = sum + 1;
        end
    end
    kcf_acc(i)= sum/numel(iou_kcf);
end

MOSSE_acc = zeros(1,numel(thresh));
for i = 1:numel(thresh)
    sum = 0;
    for j = 1:numel(iou_MOSSE)
        if iou_MOSSE(j) > thresh(i)
            sum = sum + 1;
        end
    end
    MOSSE_acc(i)= sum/numel(iou_MOSSE);
end

MIL_acc = zeros(1,numel(thresh));
for i = 1:numel(thresh)
    sum = 0;
    for j = 1:numel(iou_MIL)
        if iou_MIL(j) > thresh(i)
            sum = sum + 1;
        end
    end
    MIL_acc(i)= sum/numel(iou_MIL);
end

eco_acc = zeros(1,numel(thresh));
for i = 1:numel(thresh)
    sum = 0;
    for j = 1:numel(iou_eco)
        if iou_eco(j) > thresh(i)
            sum = sum + 1;
        end
    end
    eco_acc(i)= sum/numel(iou_eco);
end
% 
% 
plot(thresh,new_total,'Color',[0.643 0.2 0.227],'LineWidth',1.5);
hold on;
plot(thresh,MOSSE_acc,'Color',[0.3 0.5 0.74],'LineWidth',1.5);
hold on;
plot(thresh,kcf_acc,'Color',[0.815 0 0.435],'LineWidth',1.5);
hold on;
plot(thresh,MIL_acc,'Color',[0.61 0.73 0.35],'LineWidth',1.5);
hold on;
plot(thresh,eco_acc,'Color',[0.5 0.39 0.635],'LineWidth',1.5);

xlabel('IoU阈值');
ylabel('成功率');
title('IoU阈值-成功率曲线');
legend('improved STAPLE(proposed)','MOSSE','KCF','MIL','ECO');

%% robustness
% new_ro = 0;
% for i = 1:numel(new_total)
%     if(new_total(i) == 0)
%         new_ro = new_ro +1;
%     end
% end
% new_ro = new_ro/numel(new_total);
% 
% kcf_ro = 0;
% for i = 1:numel(iou_kcf)
%     if(iou_kcf(i) == 0)
%         kcf_ro = kcf_ro +1;
%     end
% end
% kcf_ro = kcf_ro/numel(iou_kcf);



