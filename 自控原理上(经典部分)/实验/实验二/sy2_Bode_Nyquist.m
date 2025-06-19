clc
clear
% 表格数据
% F = [0.16	,0.32	,0.64	,1.11	,1.59	,2.39	,3.18	,4.78	,6.37	,11.1	,15.9];  % 频率 (Hz)
omega = [1,2,4,7,10,15,20,30,40,70,100 ];
% dB = [-0.0104	,-0.0621	,-0.7661	,-2.3723	,-4.1760	,-7.4912	,-10.7124	,-16.5582	,-21.6	,-32.68	,-39.64];  % 幅度 (dB)
% Phase = [-8.46	,-23.374	,-37.9649	,-63.6163	,-83.9138	,-110.1312	,-132.2244	,-164.3364	,-180.7	,-187.812	,-196.3332]; % 相位 (度)

dB = [-0.057	,-0.215	,-0.8287	,-2.27	,-4.06	,-7.277	,-10.436	,-16.118	,-21.046	,-32.6	,-40.92];
Phase = [-8.784	,-19.1	,-38.592	,-59.82	,-82.082	,-107.206	,-125.928	,-156.85	,-174.742	,-214.5	,-235.83];
%% 

% 创建一个新的图形窗口
figure;

% 幅度伯德图
% subplot(2,1,1); % 两行一列的第一个子图
h5=semilogx(omega, dB, 'LineWidth', 2); % 使用对数尺度绘制幅度响应
grid on;
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
title('08022311 Bode图');
xlim([min(omega) max(omega)]); % 设置 x 轴范围
ylim([min(dB)-5 max(dB)+5]); % 设置 y 轴范围


% 在幅度图上绘制斜率为 -20dB/dec, -40dB/dec, -60dB/dec 的切线
hold on; % 保持当前图像

% 定义频率范围
omega_min = min(omega);
omega_max = max(omega);
freq_range = logspace(log10(omega_min), log10(omega_max), 100);

% 定义切线的起始点
% 假设从某个频率 omega_0 开始，幅度大约是 dB_0
% 起始频率，可以根据需要调整
omega_1=6.5;
omega_2=12;
omega_3=21;
omega_4=10;
omega_5=1/0.047;
omega_6=50;
dB_0 = 0;  % 对应于 omega_0 频率的幅度

% 计算切线
% 切线方程 dB = dB_0 + S * log10(omega/omega_0)
S1 = -20; % -20 dB/dec
S2 = -40; % -40 dB/dec
S3 = -60; % -60 dB/dec

dB_tangent1 = dB_0 + S1 * log10(freq_range / omega_1);
dB_tangent2 = dB_0 + S2 * log10(freq_range / omega_2);
dB_tangent3 = dB_0 + S3 * log10(freq_range / omega_3);
dB_tangent4 = dB_0 + S1 * log10(freq_range / omega_4);
dB_tangent5 = dB_0 + S2 * log10(freq_range / omega_5);
dB_tangent6 = dB_0 + S3 * log10(freq_range / omega_6);

omega_12 = 10^((S1*log10(omega_1) - S2*log10(omega_2)) / (S1 - S2));
omega_23 = 10^((S2*log10(omega_2) - S3*log10(omega_3)) / (S2 - S3));
text(omega_12, dB_0 + S1 * log10(omega_12 / omega_1), sprintf('(%0.2f, %0.2f)', omega_12, dB_0 + S1 * log10(omega_12 / omega_1)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 10);
text(omega_23, dB_0 + S2 * log10(omega_23 / omega_2), sprintf('(%0.2f, %0.2f)', omega_23, dB_0 + S2 * log10(omega_23 / omega_2)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 10);
scatter(omega_12, dB_0 + S1 * log10(omega_12 / omega_1), 37, 'k', 'filled', 'LineWidth', 2);
scatter(omega_23, dB_0 + S2 * log10(omega_23 / omega_2), 37, 'k', 'filled', 'LineWidth', 2);

% 输出交点频率
disp(['交点频率 omega_12 = ', num2str(omega_12)]);
disp(['交点频率 omega_23 = ', num2str(omega_23)]);

% 绘制切线
semilogx(freq_range, dB_tangent1, ':', 'LineWidth', 1.5, 'Color', 'r');
semilogx(freq_range, dB_tangent2, ':', 'LineWidth', 1.5, 'Color', 'g');
semilogx(freq_range, dB_tangent3, ':', 'LineWidth', 1.5, 'Color', 'b');

semilogx(freq_range, dB_tangent4, '--', 'LineWidth', 1.5, 'Color', 'r');
semilogx(freq_range, dB_tangent5, '--', 'LineWidth', 1.5, 'Color', 'g');
semilogx(freq_range, dB_tangent6, '--', 'LineWidth', 1.5, 'Color', 'b');

% 添加图例
legend('Bode图', 'Slope = -20 dB/dec', 'Slope = -40 dB/dec', 'Slope = -60 dB/dec');

hold on;

% 示例数据：x 和 y 坐标分别表示折线段的端点
x1 = [1, omega_1];  % 第一个折线段的 x 坐标
y1 = [0, 0];  % 第一个折线段的 y 坐标

x2 = [omega_1, omega_12];  % 第二个折线段的 x 坐标
y2 = [0, dB_0 + S1 * log10(omega_12 / omega_1)];  % 第二个折线段的 y 坐标

x3 = [omega_12, omega_23];  % 第二个折线段的 x 坐标
y3 = [dB_0 + S1 * log10(omega_12 / omega_1), dB_0 + S2 * log10(omega_23 / omega_2)];  % 第二个折线段的 y 坐标

x4 = [omega_23, 100];  % 第二个折线段的 x 坐标
y4 = [dB_0 + S2 * log10(omega_23 / omega_2), dB_0 + S3* log10(100 / omega_3)];  % 第二个折线段的 y 坐标

% 绘制其他线条并显示图例
% h5 = semilogx(omega, dB, 'LineWidth', 2, 'DisplayName', 'Magnitude Response');
h6 = semilogx(freq_range, dB_tangent1, ':', 'LineWidth', 1.5, 'Color', 'r', 'DisplayName', '-20 dB/dec');
h7 = semilogx(freq_range, dB_tangent2, ':', 'LineWidth', 1.5, 'Color', 'g', 'DisplayName', '-40 dB/dec');
h8 = semilogx(freq_range, dB_tangent3, ':', 'LineWidth', 1.5, 'Color', 'b', 'DisplayName', '-60 dB/dec');

% 绘制第一条线，不显示图例
h1 = semilogx(x1, y1, 'k', 'LineWidth', 2, 'DisplayName', '折线Bode');  

% 绘制第二条线，不显示图例
h2 = semilogx(x2, y2, 'k', 'LineWidth', 2, 'DisplayName', '');  

% 绘制第三条线，不显示图例
h3 = semilogx(x3, y3, 'k', 'LineWidth', 2, 'DisplayName', '');  

% 绘制第四条线，不显示图例
h4 = semilogx(x4, y4, 'k', 'LineWidth', 2, 'DisplayName', '');  

% 添加图例
legend([h5, h6, h7, h8, h1]); % 只显示你想要的图例
% 结束
hold off;

% % 相位伯德图
% subplot(2,1,2); % 两行一列的第二个子图
% semilogx(omega, Phase, 'LineWidth', 2); % 使用对数尺度绘制相位响应
% grid on;
% xlabel('Frequency (rad/s)');
% ylabel('Phase (Degrees)');
% title('Bode Plot - Phase Response');
% xlim([min(omega) max(omega)]); % 设置 x 轴范围
% ylim([min(Phase)-5 max(Phase)+5]); % 设置 y 轴范围
%% 


% % 转换 dB 为线性幅度
% Magnitude = 10.^(dB / 20);
% 
% % 将相位转换为弧度
% Phase_rad = deg2rad(Phase);
% 
% % 计算复数频率响应
% H = Magnitude .* (cos(Phase_rad) + 1i * sin(Phase_rad));
% 
% % 创建一个新的图形窗口
% figure;
% 
% % 绘制 Nyquist 图
% plot(real(H), imag(H), 'LineWidth', 2);
% grid on;
% xlabel('Real Part');
% ylabel('Imaginary Part');
% title('08022311 Nyquist Plot');
% axis equal; % 保持横纵坐标比例一致
% 




%% 

% 
% 
% % 将 dB 转换为实际幅度
% Amplitude = 10.^(dB / 20);
% 
% % 创建两个子图
% figure;
% 
% % 绘制幅度频率特性图
% subplot(2, 1, 1);
% semilogx(omega, Amplitude, 'b', 'LineWidth', 2);  % 使用log尺度绘图
% title('08022311 实际幅度频率特性');
% xlabel('频率 (\omega) [rad/s]');
% ylabel('幅度 (实际值)');
% grid on;
% 
% % 绘制相位频率特性图
% subplot(2, 1, 2);
% semilogx(omega, Phase, 'r', 'LineWidth', 2);  % 使用log尺度绘图
% title('相位频率特性');
% xlabel('频率 (\omega) [rad/s]');
% ylabel('相位 (度)');
% grid on;