clc,clear,close all%08022311
%% (1)
% 定义传递函数
num = [0.05, 1];  % 分子系数
den = [0.02, 0.3, 1];  % 分母系数，展开为 0.2s^2 + 0.3s + 1
% 创建传递函数对象
H = tf(num, den);
% 通过 tf2zp 函数将传递函数转为零极点增益形式
[z, p, k] = tf2zp(num, den);  % 返回零点、极点和增益
% 显示零点、极点和增益
disp('零点：');
disp(z);  % 显示零点
disp('极点：');
disp(p);  % 显示极点
disp('增益：');
disp(k);  % 显示增益
% 转换为状态空间形式
sys_ss = ss(H);  % 转换为状态空间
% 显示状态空间矩阵
disp('状态空间表达式：');
disp('A = ');
disp(sys_ss.A);
disp('B = ');
disp(sys_ss.B);
disp('C = ');
disp(sys_ss.C);
disp('D = ');
disp(sys_ss.D);
%% (2)
% 定义传递函数 H1(s) 和 H2(s)
H1 = tf([1, 5], conv([1,0],conv([1,1],[1,2])));  % (s+5)/s(s+1)(s+2)
H2 = tf(1, [1, 1]);  % 1/(s+1)
% (1) 串联
H_series = series(H1, H2);
disp('串联传递函数:');
disp(H_series);
% (2) 并联
H_parallel = parallel(H1, H2);
disp('并联传递函数:');
disp(H_parallel);
% (3) 负反馈
H_feedback = feedback(H1, H2);  % 默认反馈为单位反馈
disp('负反馈传递函数:');
disp(H_feedback);
%% (3)
% 绘制Bode图
figure;
bode(H_series);
grid on;
title('Bode Plot of H_{series}(s)');
% 求幅值裕度（Gain Margin, GM）和相位裕度（Phase Margin, PM）
[GM, PM, Wcg, Wcp] = margin(H_series);
% 将幅值裕度和相位裕度转换为分贝
GM_dB = 20 * log10(GM);
% 输出裕度信息
disp('系统裕度信息:');
fprintf('幅值裕度（Gain Margin, GM）：%.2f dB\n', GM_dB);
fprintf('相位裕度（Phase Margin, PM）：%.2f degrees\n', PM);
fprintf('幅值交越频率（Gain Crossover Frequency, Wcg）：%.2f rad/s\n', Wcg);
fprintf('相位交越频率（Phase Crossover Frequency, Wcp）：%.2f rad/s\n', Wcp);
%% (4)
% 定义开环传递函数 G(s)
numerator = -1;                 % 分子系数 K 作为比例放在外部分析
denominator = conv([1, 2], [1, 2, 5]);  % 分母 (s+2)(s^2+2s+5)
G = tf(numerator, denominator);
% 绘制根轨迹图
figure;
rlocus(G);  % 根轨迹
title('Root Locus of G(s)');
grid on;
% 绘制奈奎斯特曲线
figure;
nyquist(G);
title('Nyquist Plot of G(s)');
grid on;
% 求稳定时增益 K 的范围
% 使用 rlocus 找特征根实部的符号变化
[~, poles] = rlocus(G);
real_poles = real(poles);  % 提取极点实部
% 判断稳定性，找所有实部小于 0 时的增益 K
stable_gains = rlocus(G);  % 获取所有增益范围对应的极点
% 输出结果
disp('根据根轨迹分析系统稳定时的增益范围:');
disp('K 的值满足系统稳定的条件。可以通过图观察细节。');


