close all;

file = fopen("results/pickname.txt");
data = textscan(file, '%s');
fclose(file);
seq_name = data{1};

relative_path = "results/";
txtsuffix = ".txt";

total_iou = [0];

for i =1:numel(seq_name)
    full_path_name = relative_path+seq_name(i)+txtsuffix;
    file = fopen(full_path_name);
    data = textscan(file, '%f %f');
    iou = data{1};
    fps = data{2};
    
    total_iou = [total_iou; iou];    
end

threshold = 0:0.1:1;
success_num = zeros(1,numel(threshold));

for j = 1:numel(threshold)
    temp_thresh = threshold(j);
    temp_num = 0;
    for m = 1:numel(total_iou)
        if total_iou(m)>temp_thresh
            temp_num = temp_num +1;
        end
    end
    success_num(j) = temp_num/numel(total_iou);
end
    
 plot(threshold,success_num);   
    
    
    
