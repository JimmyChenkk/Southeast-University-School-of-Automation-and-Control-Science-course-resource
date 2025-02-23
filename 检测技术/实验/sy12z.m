clc,clear
%% 6
% % 原始数据
% X_original = [-6.0, -5.8, -5.6, -5.4, -5.2, -5.0, -4.8, -4.6, -4.4, -4.2, -4.0, -3.8, -3.6, -3.4, -3.2, ...
%               -3.0, -2.8, -2.6, -2.4, -2.2, -2.0, -1.8, -1.6, -1.4, -1.2, -1.0, -0.8, -0.6, -0.4, -0.2, 0.0, ...
%                3.0,  2.8,  2.6,  2.4,  2.2,  2.0,  1.8,  1.6,  1.4,  1.2,  1.0,  0.8,  0.6,  0.4,  0.2, ...
%                6.0,  5.8,  5.6,  5.4,  5.2,  5.0,  4.8,  4.6,  4.4,  4.2,  4.0,  3.8,  3.6,  3.4,  3.2];
% V_original = [1701, 1616, 1557, 1491, 1445, 1386, 1307, 1281, 1228, 1182, 1143, 1051, 1011, 979, 887, ...
%               834, 795, 722, 670, 604, 552, 499, 447, 394, 328, 276, 230, 164, 125, 59, 39, ...
%               887, 814, 768, 729, 657, 611, 545, 486, 427, 374, 342, 263, 230, 164, 112, ...
%               1760, 1701, 1655, 1583, 1542, 1478, 1419, 1366, 1294, 1235, 1189, 1123, 1051, 1005, 939];
% 
% % 新的 X 值
% X_new(1,:) = -6:0.2:6;
% 
% % 对应 V 值
% V_new = interp1(X_original, V_original, X_new, 'linear'); % 线性插值
% X_new1(1,:)=X_new(1,:);
% X_new1(2,:)=V_new;
% % 显示结果
% % disp('X (mm):');
% % disp(X_new);
% % disp('V (mV):');
% % disp(V_new);
% 
% 
% Xtable(1:2,:)=X_new1(1:2,1:15);
% Xtable(3:4,:)=X_new1(1:2,16:30);
% Xtable(5:6,:)=X_new1(1:2,32:46);
% Xtable(7:8,:)=X_new1(1:2,47:61);
% Xtable(3,16)=0;
% Xtable(4,16)=39;
% 
% 
% figure;
% plot(X_new, V_new, 'b-', 'LineWidth', 1.5); % 绘制插值后曲线
% grid on;
% xlabel('X (mm)');
% ylabel('V (mV)');
% title('Vop-p－X曲线');
% 
% 
% X_pos = X_new(X_new >= 0);
% V_pos = V_new(X_new >= 0);
% X_neg = X_new(X_new <= 0);
% V_neg = V_new(X_new <= 0);
% 
% % 拟合正部分
% p_pos = polyfit(X_pos, V_pos, 1); % 一次多项式拟合
% V_fit_pos = polyval(p_pos, X_pos); % 计算拟合值
% sensitivity_pos = p_pos(1); % 灵敏度 (斜率)
% sensitivity1=(V_pos(1,6)-V_pos(1,1))/(X_pos(1,6)-X_pos(1,1));
% sensitivity3=(V_pos(1,16)-V_pos(1,1))/(X_pos(1,16)-X_pos(1,1));
% % 拟合负部分
% p_neg = polyfit(X_neg, V_neg, 1); % 一次多项式拟合
% V_fit_neg = polyval(p_neg, X_neg); % 计算拟合值
% sensitivity_neg = p_neg(1); % 灵敏度 (斜率)
% sensitivity_1=(V_neg(1,6)-V_neg(1,1))/(X_neg(1,6)-X_neg(1,1));
% sensitivity_3=(V_neg(1,16)-V_neg(1,1))/(X_neg(1,16)-X_neg(1,1));
% % 计算非线性误差
% range_V = max(V_new) - min(V_new); % 电压量程
% nonlinear_error_pos = (V_pos - V_fit_pos) / range_V * 100; % 正部分非线性误差
% nonlinear_error_neg = (V_neg - V_fit_neg) / range_V * 100; % 负部分非线性误差
% nonlinear_error1 = (V_pos(1,6) - V_fit_pos(1,6)) / range_V * 100; % 正部分非线性误差
% nonlinear_error3 = (V_pos(1,16) - V_fit_pos(1,16)) / range_V * 100; % 负部分非线性误差
% nonlinear_error_1 = (V_neg(1,6) - V_fit_neg(1,6)) / range_V * 100; % 正部分非线性误差
% nonlinear_error_3 = (V_neg(1,16) - V_fit_neg(1,16)) / range_V * 100; % 负部分非线性误差
% % 计算位移为 ±1mm 和 ±3mm 时的灵敏度
% disp('Sensitivity灵敏度:');
% disp(['Positive part (X > 0): ', num2str(sensitivity_pos), ' mV/mm']);
% disp(['Negative part (X < 0): ', num2str(sensitivity_neg), ' mV/mm']);
% disp(['X = +1mm: ', num2str(sensitivity1), ' mV/mm']);
% disp(['X = -1mm: ', num2str(sensitivity_1), ' mV/mm']);
% disp(['X = +3mm: ', num2str(sensitivity3), ' mV/mm']);
% disp(['X = -3mm: ', num2str(sensitivity_3), ' mV/mm']);
% 
% disp('Nonlinear error非线性误差:');
% disp(['Positive part max error: ', num2str(max(abs(nonlinear_error_pos))), ' %']);
% disp(['Negative part max error: ', num2str(max(abs(nonlinear_error_neg))), ' %']);
% disp(['X = +1mm: ', num2str(nonlinear_error1), ' %']);
% disp(['X = -1mm: ', num2str(nonlinear_error_1), ' %']);
% disp(['X = +3mm: ', num2str(nonlinear_error3), ' %']);
% disp(['X = -3mm: ', num2str(nonlinear_error_3), ' %']);
% 
% % 绘制拟合结果
% figure;
% hold on;
% plot(X_pos, V_pos, 'bo', 'DisplayName', 'X > 0 Actual Data');
% plot(X_pos, V_fit_pos, 'b-', 'DisplayName', 'X > 0 Fitted Line');
% plot(X_neg, V_neg, 'ro', 'DisplayName', 'X < 0 Actual Data');
% plot(X_neg, V_fit_neg, 'r-', 'DisplayName', 'X < 0 Fitted Line');
% grid on;
% xlabel('X (mm)');
% ylabel('V (mV)');
% title('Fitted Linear Curves for X > 0 and X < 0');
% legend show;


%% 10
% % X 数据
% X = [14.450, 14.950, 15.450, 15.950, 16.450, 16.950, 17.450, 17.950, 18.450, 18.950, 19.450];
% % V 数据
% V = [914, 749, 557, 371, 196, 31, -151, -339, -533, -724, -914];
% 
% table(1,:)=X;
% table(2,:)=V;
% 
% % 使用polyfit进行线性拟合，拟合一次多项式（即线性）
% p = polyfit(X, V, 1);  % p(1)为斜率S，p(2)为截距b
% 
% % 提取拟合结果
% S = p(1);  % 灵敏度 S（斜率）
% b = p(2);  % 截距 b
% 
% % 计算拟合值
% V_fit = polyval(p, X);  % 根据X值计算拟合的V值
% 
% % 计算非线性误差 δ
% delta = V - V_fit;  % 实际值与拟合值的差异
% 
% % 显示结果
% disp(['拟合直线的灵敏度 S: ', num2str(S)]);
% disp('非线性误差 δ:');
% disp(delta);
% 
% % 绘制原始数据和拟合直线
% figure;
% plot(X, V, 'o', 'MarkerFaceColor', 'r');  % 原始数据
% hold on;
% plot(X, V_fit, '-b', 'LineWidth', 2);  % 拟合的直线
% xlabel('X (mm)');
% ylabel('V (mV)');
% title('X vs V and Fitted Line');
% legend('Original Data', 'Fitted Line');
% grid on;


%% 11
% % 给定的频率数据 (f) 和电压峰峰值 (V)
% f = [5, 7, 12, 15, 17, 20, 25];  % 频率 (Hz)
% V = [0.197, 1.287, 5.044, 2.542, 2.515, 2.246, 1.721];  % 电压峰峰值 (V)
% 
% 
% 
% % 绘制原始数据点
% figure;
% plot(f, V, 'bo-', 'MarkerFaceColor','b');  % 原始数据点（蓝色圆点并连接成折线）
% hold on;
% 
% 
% % 添加图形标题和标签
% title('Frequency vs Voltage (Peak-to-Peak)');
% xlabel('Frequency (Hz)');
% ylabel('Voltage (V, peak-to-peak)');
% legend('Data points', 'Fitted curve');
% grid on;
% hold off;


%% 12
% 给定X（位置）和U（电压）数据
X = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, ...
     1.0, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, ...
     2.0, 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9, ...
     3.0, 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, ...
     4.1, 4.2, 4.3, 4.4, 4.5, 4.6, 4.7, 4.8, 4.9, 5.0];  % X位置(mm)
U = [1.13, 1.27, 1.41, 1.55, 1.71, 1.87, 2.04, 2.21, 2.41, 2.61, ...
     2.80, 3.03, 3.26, 3.49, 3.73, 3.99, 4.25, 4.54, 4.82, 5.12, ...
     5.44, 5.77, 6.10, 6.43, 6.77, 7.13, 7.52, 7.90, 8.27, 8.62, ...
     8.96, 9.25, 9.58, 9.88, 10.18, 10.46, 10.74, 11.02, 11.27, 11.54, ...
     11.74, 11.81, 11.84, 11.86, 11.87, 11.89, 11.89, 11.90, 11.91, 11.91];  % U电压(V)

% 分别提取前20个数据点和后20个数据点
X1 = X(1:20);
U1 = U(1:20);
X2 = X(21:40);
U2 = U(21:40);

% 对前20个数据进行线性拟合
p1 = polyfit(X1, U1, 1);  % p1(1)为前20个数据的拟合斜率
U1_fit = polyval(p1, X1);

% 对后20个数据进行线性拟合
p2 = polyfit(X2, U2, 1);  % p2(1)为后20个数据的拟合斜率
U2_fit = polyval(p2, X2);

% 绘制原始数据点和拟合直线
figure;
hold on;
plot(X, U, 'o', 'DisplayName', '原始数据');  % 绘制原始数据点
plot(X1, U1_fit, '-', 'DisplayName', '前20个数据拟合直线');  % 绘制前20个数据的拟合线
plot(X2, U2_fit, '-', 'DisplayName', '后20个数据拟合直线');  % 绘制后20个数据的拟合线
hold off;

% 添加图例和标签
legend show;
xlabel('X (mm)');
ylabel('U (V)');
title('前后20个数据拟合直线');
grid on;






