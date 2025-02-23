clc,clear
%% 17
% 数据
voltage = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]; % 电压 (V)
speed = [41, 65, 88, 113, 136, 158, 183, 207, 229, 252]; % 转速 (rad/min)

% 绘制图形
figure; % 创建图形窗口
plot(voltage, speed, '-o', 'LineWidth', 1.5, 'MarkerSize', 8); % 线性图

% 设置图形属性
xlabel('电压 (V)', 'FontSize', 12); % 横坐标标签
ylabel('转速 (rad/min)', 'FontSize', 12); % 纵坐标标签
title('电压与转速的关系08022311', 'FontSize', 14); % 图形标题
grid on; % 显示网格
set(gca, 'FontSize', 12); % 设置坐标轴字体大小

