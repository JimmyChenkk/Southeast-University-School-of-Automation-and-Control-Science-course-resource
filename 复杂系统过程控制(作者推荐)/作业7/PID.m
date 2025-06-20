% % % % % % clc; clear; close all;
% % % % % % 
% % % % % % % s = tf('s');
% % % % % % % numerator = [-0.5848*0.3549, 0.5848];
% % % % % % % denominator = [0.1858, 0.8627, 1];
% % % % % % % G = tf(numerator, denominator);
% % % % % % % 
% % % % % % % %%
% % % % % % % Ts1 = 2.9;
% % % % % % % Gd1 = c2d(G, Ts1, 'zoh');  
% % % % % % % k_cu = 5.18105;
% % % % % % % P_u = 29;  
% % % % % % % 
% % % % % % % % %P                     
% % % % % % % % Kp_ZN = 0.5 * k_cu;    
% % % % % % % % Ki_ZN = 0;             
% % % % % % % % Kd_ZN = 0;             
% % % % % % % %
% % % % % % % % %PI
% % % % % % % % Kp_ZN = 0.45 * k_cu;
% % % % % % % % Ki_ZN = 0.54 * k_cu / P_u;
% % % % % % % % Kd_ZN = 0;
% % % % % % % % % 
% % % % % % % %PID
% % % % % % % Kp_ZN = 0.6 * k_cu;
% % % % % % % Ki_ZN = 1.2 * k_cu / P_u;
% % % % % % % Kd_ZN = 0.075 * k_cu * P_u;
% % % % % % % 
% % % % % % % PID_ZN = pid(Kp_ZN, Ki_ZN, Kd_ZN, 'Ts',Ts1);
% % % % % % % sys_cl_ZN = feedback(PID_ZN * Gd1, 1);
% % % % % % % 
% % % % % % % N1 = 20;
% % % % % % % t1 = 0:Ts1:(N1-1)*Ts1;
% % % % % % % [y_ZN, t_ZN] = step(sys_cl_ZN, t1);
% % % % % % % 
% % % % % % % figure;
% % % % % % % stairs(t_ZN, y_ZN, 'r', 'LineWidth', 1.5);
% % % % % % % grid on;
% % % % % % % xlabel('Time (s)');
% % % % % % % ylabel('System Response');
% % % % % % % title('Closed-loop oscillation method（Ts = 2.9s）');
% % % % % % 
% % % % % % 
% % % % % % clc; clear; close all;
% % % % % % 
% % % % % % s = tf('s');
% % % % % % numerator = [-0.5848*0.3549, 0.5848];
% % % % % % denominator = [0.1858, 0.8627, 1];
% % % % % % G = tf(numerator, denominator);
% % % % % % 
% % % % % % %%
% % % % % % Ts1 = 2.9;
% % % % % % Gd1 = c2d(G, Ts1, 'zoh');  
% % % % % % k_cu = 5.18105;
% % % % % % P_u = 29;  
% % % % % % 
% % % % % % % PID controller parameters
% % % % % % Kp_ZN = 0.6 * k_cu;
% % % % % % Ki_ZN = 1.2 * k_cu / P_u;
% % % % % % Kd_ZN = 0.075 * k_cu * P_u;
% % % % % % 
% % % % % % PID_ZN = pid(Kp_ZN, Ki_ZN, Kd_ZN, 'Ts',Ts1);
% % % % % % sys_cl_ZN = feedback(PID_ZN * Gd1, 1);
% % % % % % 
% % % % % % % Define the time vector starting from 0 and ending at 20 seconds, with a step at 5 seconds
% % % % % % N1 = 20;
% % % % % % t1 = 0:Ts1:(N1-1)*Ts1;
% % % % % % u = zeros(size(t1)); % Create a unit step input vector
% % % % % % u(t1 >= 5) = 1; % Change the input to 2 at t = 5 seconds and beyond
% % % % % % 
% % % % % % % Simulate the system response
% % % % % % [y_ZN, t_ZN] = lsim(sys_cl_ZN, u, t1);
% % % % % % 
% % % % % % figure;
% % % % % % stairs(t_ZN, y_ZN, 'r', 'LineWidth', 1.5);
% % % % % % grid on;
% % % % % % xlabel('Time (s)');
% % % % % % ylabel('System Response');
% % % % % % title('Closed-loop oscillation method（Ts = 2.9s）');
% % % % % % 
% % % % % % 
% % % % % % % Tf = 0.15 * Kd_ZN;  
% % % % % % % 
% % % % % % % PID_noKick = pid2(Kp_ZN, Ki_ZN, Kd_ZN, Tf, 'Ts', Ts1);
% % % % % % % 
% % % % % % % % sys_cl_ZN = feedback(PID_ZN * Gd1, 1);
% % % % % % % sys_cl_noKick = feedback(PID_noKick *Gd1, [1; 1]);  % 适用于 MISO (1×2) 系统
% % % % % % % 
% % % % % % % %% **阶跃响应**
% % % % % % % % N1 = 20;
% % % % % % % % t1 = 0:Ts1:(N1-1)*Ts1;
% % % % % % % % [y_ZN, t_ZN] = step(sys_cl_ZN, t1);
% % % % % % % [y_noKick, t_noKick] = step(sys_cl_noKick, t1);
% % % % % % % 
% % % % % % % figure;
% % % % % % % hold on;
% % % % % % % stairs(t_ZN, y_ZN, 'r', 'LineWidth', 1.5);  % 标准 PID
% % % % % % % stairs(t_noKick, y_noKick(:, :, 1), 'b', 'LineWidth', 2.5);  % 第一个通道
% % % % % % % hold on;
% % % % % % % stairs(t_noKick, -y_noKick(:, :, 2), 'y:o', 'LineWidth', 1.5);  % 第二个通道
% % % % % % % legend('Channel 1', 'Channel 2');
% % % % % % % grid on;
% % % % % % % xlabel('Time (s)');
% % % % % % % ylabel('System Response');
% % % % % % % title('Comparison: Standard PID vs. No Derivative Kick PID');
% % % % % % % legend('Standard PID', 'No Derivative Kick PID');
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % % % 设定采样时间
% % % % % % % Ts1 = 2.9;
% % % % % % % 
% % % % % % % % Ziegler-Nichols (ZN) 参数
% % % % % % % k_cu = 5.18105;
% % % % % % % P_u = 29;
% % % % % % % 
% % % % % % % Kp_ZN = 0.6 * k_cu;
% % % % % % % Ki_ZN = 1.2 * k_cu / P_u;
% % % % % % % Kd_ZN = 0.075 * k_cu * P_u;
% % % % % % % 
% % % % % % % % 设定微分滤波系数
% % % % % % % N = 0.0997; 
% % % % % % % 
% % % % % % % % 定义 PID（微分先行）为 PD + I 结构
% % % % % % % s = tf('s');
% % % % % % % PD_part = Kp_ZN + Kd_ZN * (N / (s + N));  % PD 部分 (微分项带滤波)
% % % % % % % I_part = Ki_ZN / s;  % 积分项
% % % % % % % PID_DF = PD_part + I_part;  % 组合成 PD + I
% % % % % % % 
% % % % % % % % 离散化 PID 控制器
% % % % % % % PID_DF_discrete = c2d(PID_DF, Ts1, 'zoh');  % 使用零阶保持方法离散化
% % % % % % % 
% % % % % % % % 离散化的 plant 系统
% % % % % % % Gd1 = c2d(G, Ts1, 'zoh');
% % % % % % % 
% % % % % % % % 闭环系统
% % % % % % % sys_cl_DF = feedback(PID_DF_discrete * Gd1, 1);
% % % % % % % 
% % % % % % % % 进行仿真
% % % % % % % N1 = 20;
% % % % % % % t1 = 0:Ts1:(N1-1)*Ts1;
% % % % % % % [y_DF, t_DF] = step(sys_cl_DF, t1);
% % % % % % % 
% % % % % % % % 画图对比
% % % % % % % figure;
% % % % % % % stairs(t_ZN, y_ZN, 'r', 'LineWidth', 1.5);
% % % % % % % hold on;
% % % % % % % stairs(t_DF, y_DF, 'b', 'LineWidth', 1.5);
% % % % % % % grid on;
% % % % % % % xlabel('Time (s)');
% % % % % % % ylabel('System Response');
% % % % % % % title('Closed-loop response with Derivative First (Ts = 2.9s)');
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % % 设定采样时间
% % % % % % Ts1 = 2.9;
% % % % % % 
% % % % % % % Ziegler-Nichols (ZN) 参数
% % % % % % k_cu = 5.18105;
% % % % % % P_u = 29;
% % % % % % 
% % % % % % Kp_ZN = 0.6 * k_cu;
% % % % % % Ki_ZN = 1.2 * k_cu / P_u;
% % % % % % Kd_ZN = 0.075 * k_cu * P_u;
% % % % % % 
% % % % % % % 设定微分滤波系数
% % % % % % N = 0.0997; 
% % % % % % 
% % % % % % % 定义 PID（微分先行）为 PD + I 结构
% % % % % % PD_part = Kp_ZN + Kd_ZN * (N / (s + N));  % PD 部分 (微分项带滤波)
% % % % % % I_part = Ki_ZN / s;  % 积分项
% % % % % % PID_DF = PD_part + I_part;  % 组合成 PD + I
% % % % % % 
% % % % % % % 离散化 PID 控制器
% % % % % % PID_DF_discrete = c2d(PID_DF, Ts1, 'zoh');  % 使用零阶保持方法离散化
% % % % % % 
% % % % % % % 离散化的 plant 系统
% % % % % % Gd1 = c2d(G, Ts1, 'zoh');
% % % % % % 
% % % % % % % 闭环系统
% % % % % % sys_cl_DF = feedback(PID_DF_discrete * Gd1, 1);
% % % % % % 
% % % % % % % 进行仿真
% % % % % % N1 = 20;
% % % % % % t1 = 0:Ts1:(N1-1)*Ts1;
% % % % % % u = ones(size(t1));  % 创建一个单位阶跃输入向量
% % % % % % u(t1 < 5*Ts1) = 0;  % 在5秒之前将输入设为0
% % % % % % 
% % % % % % % 使用 lsim 函数进行仿真，因为 step 函数不支持自定义输入
% % % % % % [y_DF, t_DF] = lsim(sys_cl_DF, u, t1);
% % % % % % 
% % % % % % % 绘图
% % % % % % figure;
% % % % % % plot(t_DF, y_DF, 'r', 'LineWidth', 1.5);
% % % % % % grid on;
% % % % % % xlabel('Time (s)');
% % % % % % ylabel('System Response');
% % % % % % title('Closed-loop system response with step input at 5s');
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % 
% % % % % % %%
% % % % % % % Ts3 = 1;  
% % % % % % % Gd3 = c2d(G, Ts3, 'zoh');  
% % % % % % % 
% % % % % % % Kp_try = 5.18105;
% % % % % % % Ki_try = 0;
% % % % % % % Kd_try = 0;
% % % % % % % 
% % % % % % % PID_try = pid(Kp_try, Ki_try, Kd_try,'Ts', Ts3);
% % % % % % % sys_cl_try = feedback(PID_try * Gd3, 1);
% % % % % % % 
% % % % % % % N3 = 200;
% % % % % % % t3 = 0:Ts3:(N3-1)*Ts3;
% % % % % % % [y_try, t_try] = step(sys_cl_try, t3);
% % % % % % % 
% % % % % % % figure;
% % % % % % % stairs(t_try, y_try, 'b', 'LineWidth', 1.5);
% % % % % % % grid on;
% % % % % % % xlabel('Time (s)');
% % % % % % % ylabel('System Response');
% % % % % % % title('Trial-and-Error Method (Ts = 1s)');


%% problem2
clc; clear; close all;

% Define the process transfer function
Gp = tf(2, [3 1]);

% Define the controller in PID form with lag
alpha = 1;  % Set the value of alpha
lambda = 1; % Set the value of lambda

% Controller parameters (tuned to match desired closed-loop behavior)
Kp = 0.5 * alpha;
Ki = 0.45 * alpha / lambda;
Kd = 0.6 * alpha;
tau_F = 1 / (lambda);

% PID controller with lag term
G = Kp + tf([Ki 0], [1 0]) + tf([Kd 0], [1 0]);

% Closed-loop system
Gcl = feedback(G * Gp, 1);

% Plot the step response of the closed-loop system
step(Gcl);
title('Step Response of Closed-Loop System');


