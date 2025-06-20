clear; close all; clc;

%% 1. Measured Data
k_meas = -1:20;  % 22 points
y_meas = [0, 0, 0.1044, 0.3403, 0.6105, 0.8494, 1.0234, 1.1244, 1.1616, ...
          1.1531, 1.118, 1.0742, 1.0336, 1.0023, 0.9828, 0.9744, ...
          0.9742, 0.9790, 0.9860, 0.9929, 0.9985, 1.0022];

%% 2. Estimated Model Parameters
% Given estimated discrete-time model:
%   g(z) = (b1*z^-1 + b2*z^-2) / (1 + a1*z^-1 + a2*z^-2)
Y=zeros(20,4);
Y(:,1)=y_meas(:,3:22)';
Phi(:,1)=y_meas(:,2:21)';
Phi(:,2)=y_meas(:,1:20)';
Phi(:,3)=ones(20,1);
Phi(:,4)=ones(20,1);
Phi(1,4)=0;
Theta=(inv(Phi'*Phi))*Phi'*Y;

%% 
a1_solution2 = -Theta(1,1);
a2_solution2 = -Theta(2,1);
b1_solution2 = Theta(3,1);
b2_solution2 = Theta(4,1);

num_solution2 = [0, b1_solution2, b2_solution2];   % 0*z^0 + b1*z^-1 + b2*z^-2
den_solution2 = [1, a1_solution2, a2_solution2];   % 1 + a1*z^-1 + a2*z^-2
Ts = 1;              % Sampling time (assumed to be 1 time unit)
sys_solution2 = tf(num_solution2, den_solution2, Ts);

%% 3. Simulate the Step Response from the Estimated Model
numSamples = 20;
[t_sim_solution2, y_sim] = step(sys_solution2, numSamples); 
y_est_solution2 = [0; t_sim_solution2];     
k_est = -1:20;          

%% 
a1_solution1 = -1.414;
a2_solution1 = 0.6053;
b1_solution1 = 0.1044;
b2_solution1 = 0.0869;
num_solution1 = [0, b1_solution1, b2_solution1];   % 0*z^0 + b1*z^-1 + b2*z^-2
den_solution1 = [1, a1_solution1, a2_solution1];   % 1 + a1*z^-1 + a2*z^-2
Ts = 1;              % Sampling time (assumed to be 1 time unit)
sys_solution1 = tf(num_solution1, den_solution1, Ts);

%% 3. Simulate the Step Response from the Estimated Model
numSamples = 20;
[t_sim_solution1, y_sim] = step(sys_solution1, numSamples); 
y_est_solution1 = [0; t_sim_solution1];     
k_est = -1:20;          

%% 4. Plot the Measured and Estimated Step Responses
figure;
stairs(k_meas, y_meas, 'bo-', 'LineWidth', 2, 'DisplayName', 'Measured Data'); hold on;
stairs(k_est, y_est_solution2, 'rpentagram-', 'LineWidth', 1.5, 'DisplayName', 'Solution2 Estimated Model'); hold on;
stairs(k_est, y_est_solution1, 'ghexagram-', 'LineWidth', 1, 'DisplayName', 'Solution1 Estimated Model');
xlabel('Sample Index, k');
ylabel('Response y[k]');
title('Step Response: Measured Data vs. Estimated Model');
legend('Location', 'Best');
grid on;

