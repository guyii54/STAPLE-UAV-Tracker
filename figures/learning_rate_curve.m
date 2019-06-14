
clear all;
thresh = 2.5;
f = @(x)(x<thresh)*(0.01+0.004*x)+(x>=thresh)*0.02;
q = 0:0.0001:5;
y = zeros(1,numel(q));


for i = 1:numel(q)
    
    y(i) = f(q(i));
    
end

plot(q,y,'k','LineWidth',1);
ylim([0,0.03]);
ylabel('学习率');
xlabel('置信度');
title('学习率-置信度曲线');