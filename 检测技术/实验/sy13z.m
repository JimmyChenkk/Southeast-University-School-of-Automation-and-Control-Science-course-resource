clc,clear
%% 21
% 给定数据
X = [30, 40, 50, 60, 70, 80, 90, 100, 110, 120];
Y = [3.3, 10.8, 20.5, 34.2, 37.8, 52.6, 61, 68.8, 80.7, 85.7];

% 线性拟合
p = polyfit(X, Y, 1); % 一次多项式拟合
fitted_Y = polyval(p, X); % 计算拟合的 Y 值

% 计算非线性误差
nonlinear_error = (Y - fitted_Y) ./ fitted_Y * 100; % 百分比形式

% 绘制原始数据、拟合直线及非线性误差
figure;
subplot(2, 1, 1);
plot(X, Y, 'o', 'MarkerSize', 8, 'DisplayName', '原始数据'); hold on;
plot(X, fitted_Y, '-r', 'LineWidth', 1.5, 'DisplayName', '拟合直线');
xlabel('X');
ylabel('Y');
title('原始数据及拟合直线');
legend('Location', 'northwest');
grid on;

% 绘制非线性误差
subplot(2, 1, 2);
plot(X, nonlinear_error, '-o', 'MarkerSize', 8, 'DisplayName', '非线性误差');
xlabel('X');
ylabel('非线性误差 (%)');
title('非线性误差');
legend('Location', 'northwest');
grid on;

% 显示结果
disp('拟合结果：');
disp(['拟合斜率 = ', num2str(p(1))]);
disp(['拟合截距 = ', num2str(p(2))]);
disp('非线性误差（百分比形式）：');
for i = 1:length(X)
    fprintf('X = %.1f, 非线性误差 = %.2f%%\n', X(i), nonlinear_error(i));
end



%% 24
% 数据输入
T = [50, 60, 70, 80, 90, 100, 110, 120, 130]; % 温度数据 (℃)
V = [786, 893, 1005, 1114, 1220, 1317, 1417, 1531, 1637]; % 电压数据 (mV)
E = [2.022, 2.436, 2.850, 3.266, 3.681, 4.095, 4.508, 4.919, 5.327]; % 误差数据

% 数据拟合
p_V = polyfit(T, V, 1); % 一阶多项式拟合 V-T
p_E = polyfit(T, E, 1); % 一阶多项式拟合 E-T

% 计算拟合值
V_fit = polyval(p_V, T); % V 的拟合值
E_fit = polyval(p_E, T); % E 的拟合值

% 计算非线性误差
nonlinear_error2 = (V - V_fit) ./ V_fit * 100; % 百分比形式

% 绘制曲线图
figure;

% 子图1: T-V 曲线
subplot(3, 1, 1);
plot(T, V, 'bo-', 'LineWidth', 1.5); hold on;
plot(T, V_fit, 'r--', 'LineWidth', 1.2);
title('V-T');
xlabel(' T (℃)');
ylabel(' V (mV)');
legend('实验数据', '拟合曲线');
grid on;

% 子图2: T-E 曲线
subplot(3, 1, 2);
plot(T, E, 'go-', 'LineWidth', 1.5); hold on;
plot(T, E_fit, 'm--', 'LineWidth', 1.2);
title('E(t,t0)-T');
xlabel(' T (℃)');
ylabel(' E(t,t0)');
legend('实验数据', '拟合曲线');
grid on;

% 输出拟合结果
disp('V-T 拟合直线方程：');
fprintf('V = %.3f*T + %.3f\n', p_V(1), p_V(2));

disp('E(t,t0)-T 拟合直线方程：');
fprintf('E = %.3f*T + %.3f\n', p_E(1), p_E(2));


% 数据拟合
p_VE = polyfit(V, E, 1); % 一阶多项式拟合 E-V

% 计算拟合值
E_fit = polyval(p_VE, V); % E 的拟合值

% 绘制 V-E 图
subplot(3, 1, 3);
plot(V, E, 'ro-', 'LineWidth', 1.5); hold on; % E 数据点和曲线
plot(V, E_fit, 'r--', 'LineWidth', 1.2); % E 拟合线
title('E(t,t0)-V');
xlabel(' V (mV)');
ylabel('E(t,t0)-T');
legend('误差实验数据', '误差拟合曲线', 'Location', 'best');
grid on;

% 输出拟合结果
disp('E(t,t0)-V 拟合直线方程：');
fprintf('E = %.3f*V + %.3f\n', p_VE(1), p_VE(2));


disp('非线性误差（百分比形式）：');
for i = 1:length(V)
    fprintf('T = %.1f, 非线性误差 = %.2f%%\n', T(i), nonlinear_error2(i));
end
