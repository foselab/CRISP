%% BOX PLOT 

%% ACC OTA 1
matrix1= [position_vector_HECATE_ACC_OTA_1' position_vector_APDISC_ACC_OTA_1' position_vector_RANDOM_MEDIO_ACC_OTA_1'];
figure;
boxplot(matrix1,'Labels',{'HECATE','APDISC','RANDOM'});
set(findobj(gca,'Tag','Box'), 'LineWidth', 1.5);
set(findobj(gca,'Tag','Median'), 'LineWidth', 1.5);
set(findobj(gca,'Tag','Whisker'), 'LineWidth', 1.5);
set(findobj(gca,'Tag','Outliers'), 'MarkerSize', 3);
hold on
medians = median(matrix1, 'omitnan');
positions = 1:size(matrix1,2);
for i = 1:length(medians)
    text(positions(i), medians(i), sprintf('%.3f', medians(i)), ...
         'HorizontalAlignment','center', ...
         'VerticalAlignment','bottom', ...
         'FontSize',8, 'FontWeight','bold', 'Color','k');
end
hold off
title('ACC OTA 1');
xlabel('Prioritization Algorithm')
ylabel('Simulation index')

saveas(gcf,'boxplot_ACC_OTA_1.fig');

%% ACC OTA 2 
matrix2= [position_vector_HECATE_ACC_OTA_2' position_vector_APDISC_ACC_OTA_2' position_vector_RANDOM_MEDIO_ACC_OTA_2'];
figure;
boxplot(matrix2,'Labels',{'HECATE','APDISC','RANDOM'});
set(findobj(gca,'Tag','Box'), 'LineWidth', 1.5);
set(findobj(gca,'Tag','Median'), 'LineWidth', 1.5);
set(findobj(gca,'Tag','Whisker'), 'LineWidth', 1.5);
set(findobj(gca,'Tag','Outliers'), 'MarkerSize', 3);
hold on
medians = median(matrix2, 'omitnan');
positions = 1:size(matrix2,2);
for i = 1:length(medians)
    text(positions(i), medians(i), sprintf('%.3f', medians(i)), ...
         'HorizontalAlignment','center', ...
         'VerticalAlignment','bottom', ...
         'FontSize',8, 'FontWeight','bold', 'Color','k');
end
hold off
title('ACC OTA 2');
xlabel('Prioritization Algorithm')
ylabel('Simulation index')
saveas(gcf,'boxplot_ACC_OTA_2.fig');

%% LKA OTA 1 
matrix3= [position_vector_HECATE_LKA_OTA_1' position_vector_APDISC_LKA_OTA_1' position_vector_RANDOM_MEDIO_LKA_OTA_1'];
figure;
boxplot(matrix3,'Labels',{'HECATE','APDISC','RANDOM'});
set(findobj(gca,'Tag','Box'), 'LineWidth', 1.5);
set(findobj(gca,'Tag','Median'), 'LineWidth', 1.5);
set(findobj(gca,'Tag','Whisker'), 'LineWidth', 1.5);
set(findobj(gca,'Tag','Outliers'), 'MarkerSize', 3);
hold on
medians = median(matrix3, 'omitnan');
positions = 1:size(matrix3,2);
for i = 1:length(medians)
    text(positions(i), medians(i), sprintf('%.3f', medians(i)), ...
         'HorizontalAlignment','center', ...
         'VerticalAlignment','bottom', ...
         'FontSize',8, 'FontWeight','bold', 'Color','k');
end
hold off
title('LKA OTA 1');
xlabel('Prioritization Algorithm')
ylabel('Simulation index')
saveas(gcf,'boxplot_LKA_OTA_1.fig');

%% LKA OTA 2 
matrix4= [position_vector_HECATE_LKA_OTA_2' position_vector_APDISC_LKA_OTA_2' position_vector_RANDOM_MEDIO_LKA_OTA_2'];
figure;
boxplot(matrix4,'Labels',{'HECATE','APDISC','RANDOM'});
set(findobj(gca,'Tag','Box'), 'LineWidth', 1.5);
set(findobj(gca,'Tag','Median'), 'LineWidth', 1.5);
set(findobj(gca,'Tag','Whisker'), 'LineWidth', 1.5);
set(findobj(gca,'Tag','Outliers'), 'MarkerSize', 3);
hold on
medians = median(matrix4, 'omitnan');
positions = 1:size(matrix4,2);
for i = 1:length(medians)
    text(positions(i), medians(i), sprintf('%.3f', medians(i)), ...
         'HorizontalAlignment','center', ...
         'VerticalAlignment','bottom', ...
         'FontSize',8, 'FontWeight','bold', 'Color','k');
end
hold off
title('LKA OTA 2');
xlabel('Prioritization Algorithm')
ylabel('Simulation index')
saveas(gcf,'boxplot_LKA_OTA_2.fig');

%% LKA OTA 3
matrix5= [position_vector_HECATE_LKA_OTA_3' position_vector_APDISC_LKA_OTA_3' position_vector_RANDOM_MEDIO_LKA_OTA_3'];
figure;
boxplot(matrix5,'Labels',{'HECATE','APDISC','RANDOM'});
set(findobj(gca,'Tag','Box'), 'LineWidth', 1.5);
set(findobj(gca,'Tag','Median'), 'LineWidth', 1.5);
set(findobj(gca,'Tag','Whisker'), 'LineWidth', 1.5);
set(findobj(gca,'Tag','Outliers'), 'MarkerSize', 3);
hold on
medians = median(matrix5, 'omitnan');
positions = 1:size(matrix5,2);
for i = 1:length(medians)
    text(positions(i), medians(i), sprintf('%.3f', medians(i)), ...
         'HorizontalAlignment','center', ...
         'VerticalAlignment','bottom', ...
         'FontSize',8, 'FontWeight','bold', 'Color','k');
end
hold off
title('LKA OTA 3');
xlabel('Prioritization Algorithm')
ylabel('Simulation index')
saveas(gcf,'boxplot_LKA_OTA_3.fig');