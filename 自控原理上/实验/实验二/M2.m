clc,clear,close all
X = [0.16	0.32	0.64	1.11	1.59	2.39	3.18	4.78	6.37	11.1	15.9];
Y = [-0.0568	-0.2542	-0.9115	-2.2425	-4.2368	-7.3822	-10.5141	-16.1462	-21.0176	-32.5585	-41.4226];
Z = [-11.0070	-20.7537	-38.2344	-62.5313	-81.1557	-106.1272	-128.6935	-154.4814	-171.9127	-199.7342	-222.2462];
omega = 2*pi*X;  % 转换为角频率 rad/s
omega_lg = log10(omega);
yx = spline(X,Y);
figure;

% 第一个子图：幅频特性曲线
subplot(2, 1, 1);
semilogx(omega, Y, '-o', 'LineWidth', 1.5);
xlabel('\omega (rad/s)');
ylabel('L (dB)');
title('幅频特性曲线');
xlim;
grid on;

% 第二个子图：相频特性曲线
subplot(2, 1, 2);
semilogx(omega, Z, '-o', 'LineWidth', 1.5);
xlabel('\omega (rad/s)');
ylabel('\phi (dec)');
title('相频特性曲线');
xlim;
grid on;

% 调整图形布局
sgtitle('幅频和相频特性曲线');
% Step 2: 转换增益（dB）为线性增益并估算系统的传递函数
% Y为dB值，需要转换为线性值
MagnitudeLinear = 10.^(Y/20);  % 从dB转换为线性增益
% Step 4: Nyquist图
% 从频率响应数据中生成复数平面上的Nyquist图
G = MagnitudeLinear .* exp(1i*deg2rad(Z));  % 获取复数增益

figure;
plot(real(G), imag(G), '-o', 'LineWidth', 2);
grid on;
xlabel('Real Part');
ylabel('Imaginary Part');
title('Nyquist图');
axis equal;


% 使用样条插值计算增益
omega_interp = logspace(log10(min(omega)), log10(max(omega)), 500); % 使用对数间距
omega_interpL = log10(omega_interp);
Y_interp = spline(omega, Y, omega_interp);  % 使用样条插值计算增益

% 绘制插值后的幅频特性曲线
figure;
semilogx(omega_interp, Y_interp, '-b', 'LineWidth', 2); % 插值曲线（蓝色实线）
hold on;
semilogx(omega, Y, 'ro', 'MarkerFaceColor', 'r'); % 原始实验数据（红色圆点）
xlabel('角频率 (\omega) [rad/s]');
ylabel('增益 (Y) [dB]');
grid on;
title('幅频特性曲线 (插值)');
legend('插值曲线', '实验数据');

% f(x) = 0.1818*sin(0.2638*x+c)+0.1304*x^2+0.5797*x+0.5499;
% 定义拟合函数和导数
syms x c;

% f = 0.7203*sin(3.5966*x + -2.6405) + -4.3900*x^3 + -2.2844*x^2 + 1.6113*x + 0.2935;
f = -0.6621*sin(3.7236*x + -5.8706) + -4.5276*x^3 + -1.9461*x^2 + 1.4943*x + 0.2435;


% 绘制曲线
f_plot = matlabFunction(f);  % 将符号函数转换为函数句柄
x_vals = linspace(0, 10, 500);  % x的范围，可以根据需要调整
y_vals = f_plot(x_vals);

figure;
plot(x_vals, y_vals);
title('拟合函数曲线');
xlabel('x');
ylabel('f(x)');

f = diff(f, x);  % 计算导数

% 计算斜率
% 切线斜率为 -20 dB/dec, -40 dB/dec, -60 dB/dec 对应的斜率值
slope_20dB = -20;  % -20 dB/dec
slope_40dB = -40;  % -40 dB/dec
slope_60dB = -60;  % -60 dB/dec

% 求解导数为这些斜率的x值
eq_20dB = f == slope_20dB;
eq_40dB = f == slope_40dB;
eq_60dB = f == slope_60dB;

% 求解方程
x_20dB = solve(eq_20dB, x);
x_40dB = solve(eq_40dB, x);
x_60dB = solve(eq_60dB, x);

disp('斜率为 -20 dB/dec 时的x值:');
disp(x_20dB);
disp('斜率为 -40 dB/dec 时的x值:');
disp(x_40dB);
disp('斜率为 -60 dB/dec 时的x值:');
disp(x_60dB);

w_20dB = 10^x_20dB;
w_40dB = 10^x_40dB;
w_60dB = 10^x_60dB;

disp('斜率为 -20 dB/dec 时的\omega值:');
disp(w_20dB);
disp('斜率为 -40 dB/dec 时的\omega值:');
disp(w_40dB);
disp('斜率为 -60 dB/dec 时的\omega值:');
disp(w_60dB);

disp('T1值:');
disp(1/w_20dB);
disp('T2值:');
disp(1/w_40dB);
disp('T3值:');
disp(1/w_60dB);


% 使用 fnder 函数计算样条曲线的一阶导数
pp = spline(omega, Y);  % 得到样条的 piecewise polynomial 表示
dpp = fnder(pp, 1);  % 计算样条曲线的一阶导数

% 在插值点计算导数值
dY_interp = ppval(dpp, omega_interpL);  % 在 omega_interp 点计算导数值

% 绘制插值后的幅频特性曲线
figure;
plot(omega_interpL, Y_interp, '-b', 'LineWidth', 2); % 插值曲线（蓝色实线）
hold on;
plot(log10(omega), Y, 'ro', 'MarkerFaceColor', 'r'); % 原始实验数据（红色圆点）

% 设定需要绘制切线的频率点
omega_points = [0 x_20dB, x_40dB, x_60dB];
dY_p = [0 -20 -40 -60]; % 插值曲线在该点的导数（切线的斜率）

% 对每个频率点，计算并绘制切线
for i = 1:length(omega_points)
    omega_p = omega_points(i);  % 当前频率点
    % 找到最接近的插值频率点的索引
    [~, idx] = min(abs(omega_interpL - omega_p));
    Y_p = Y_interp(idx);  % 插值曲线在该点的增益值
    
    % 切线的方程：y = dY_p * (omega_interp - omega_p) + Y_p
    Y_tangent = dY_p(i) * (omega_interpL - omega_p) + Y_p;
    
    % 绘制切线
    plot(omega_interpL, Y_tangent, 'LineWidth', 1.5);  % 切线（黑色虚线）
end

% 设置图形标签
xlabel('角频率对数 (lg\omega) [rad/s]');
xlim([min(omega_interpL) max(omega_interpL)]);
ylabel('增益 (Y) [dB]');
ylim([min(Y_interp) max(Y_interp)+5]);
grid on;
title('幅频特性曲线 (插值) 与切线');
legend('插值曲线', '实验数据', '0dB/dec切线', '-20dB/dec切线', '-40dB/dec切线', '-60dB/dec切线');
% % 计算增益变化率（斜率）
% dY = diff(Y_interp);       % 增益的差分
% dOmega = diff(omega_interp); % 对数频率的差分
% slope = dY ./ log10(dOmega); % 计算增益变化率（dB/dec）
% 
% % 设置目标斜率值
% target_slopes = [-20, -40, -60];
% tolerance = 1;  % 设定容差
% 
% % 查找符合条件的点
% for i = 1:length(target_slopes)
%     target = target_slopes(i);
%     idx = find(abs(slope - target) < tolerance); % 找到符合斜率要求的点
%     disp(['斜率接近 ', num2str(target), ' dB/dec 的点是：']);
%     disp(['频率: ', num2str(omega_interp(idx))]);
%     disp(['增益: ', num2str(Y_interp(idx))]);
% end

% % 假设找到的符合斜率的点是 idx
% idx = 50;  % 例如，斜率为 -20 dB/dec 的点在第 50 个位置
% 
% % 绘制切线（通过拟合两点）
% omega_tangent = omega_interp([idx, idx+1]);
% Y_tangent = Y_interp([idx, idx+1]);
% 
% figure;
% semilogx(omega_interp, Y_interp, '-b', 'LineWidth', 2);
% hold on;
% semilogx(omega, Y, 'ro', 'MarkerFaceColor', 'r'); % 原始数据
% plot(omega_tangent, Y_tangent, 'r--', 'LineWidth', 2); % 红色虚线表示切线
% xlabel('角频率 (\omega) [rad/s]');
% ylabel('增益 (Y) [dB]');
% grid on;
% title('幅频特性曲线及切线');
% legend('插值曲线', '实验数据', '切线');











% 
% 
% % 定义开环传递函数 G(s)
% s = tf('s');  % 定义 s 为复频域变量
% G = 1 / ((0.1*s+1)*(0.047*s+1)*(0.02*s+1));
% 
% % 绘制 Bode 图
% figure;
% bode(G);
% grid on;
% title('开环传递函数 Bode 图');

% % 计算幅值裕度和相角裕度
% [GM, PM, Wcg, Wcp] = margin(G);
% 
% % 输出幅值裕度和相角裕度
% disp(['幅值裕度 (Gain Margin) = ', num2str(GM), ' dB']);
% disp(['相角裕度 (Phase Margin) = ', num2str(PM), '°']);
% disp(['增益交叉频率 (Wcg) = ', num2str(Wcg), ' rad/s']);
% disp(['相位交叉频率 (Wcp) = ', num2str(Wcp), ' rad/s']);


% % 传递函数模型：Y = 1 / ((a*s + 1)*(b*s + 1)*(c*s + 1))
% model_func = @(params, f) 1 ./ ((params(1)*1i*2*pi*f + 1) .* (params(2)*1i*2*pi*f + 1) .* (params(3)*1i*2*pi*f + 1));
% 
% % params 是包含 a, b, c 的参数向量
% % f 是频率数据
% % 误差函数：计算拟合值与实际值之间的平方误差
% error_func = @(params, f, Y_measured) norm(model_func(params, f) - Y_measured);
% % 假设 X 是频率数据，Y 是测量的幅度响应
% % X 和 Y 必须是列向量
% 
% % 初始参数猜测值：可以根据经验或者领域知识给出合理的初始值
% initial_guess = [1, 1, 1];  % 初始猜测参数 a, b, c 的值
% 
% % 使用 lsqcurvefit 进行拟合
% params_estimated = lsqcurvefit(@(params, f) model_func(params, f), initial_guess, X, Y);
% % 绘制拟合结果
% Y_fit = model_func(params_estimated, X);  % 计算拟合曲线的 Y 值
% 
% % 绘制原始数据和拟合曲线
% figure;
% plot(X, Y, 'o', X, Y_fit, '-');  
% xlabel('频率 (Hz)');
% ylabel('幅度响应');
% legend('原始数据', '拟合曲线');
% title('数据拟合');
% grid on;
% 
% % 输出拟合的参数
% disp('拟合出的参数 a, b, c:');
% disp(params_estimated);
% % 计算拟合曲线的导数（频率响应的斜率）
% % 导数的计算通常是数值导数，你可以通过差分计算来逼近导数
% 
% f_derivative = @(params, f) diff(model_func(params, f)) / diff(f(1:2));  % 数值导数
% 
% % 查找斜率为 -20, -40, -60 对应的频率
% target_slopes = [-20, -40, -60];
% X_solutions = zeros(size(target_slopes));
% 
% for i = 1:length(target_slopes)
%     % 查找每个目标斜率对应的频率
%     slope_diff = @(f) abs(f_derivative(params_estimated, f) - target_slopes(i));  % 斜率差异
%     X_solutions(i) = fminsearch(slope_diff, X(1));  % 最小化差异，找到对应的频率
% end
% 
% % 输出频率结果
% disp('斜率为 -20, -40, -60 对应的频率：');
% disp(X_solutions);
