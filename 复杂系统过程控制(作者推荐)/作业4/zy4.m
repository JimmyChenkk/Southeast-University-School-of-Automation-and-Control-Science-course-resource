clc; clear; close all;

% Constants
F0 = 100;    % Initial flow rate (L/h)
F_new = 110; % New flow rate after step change (L/h)
V1 = 2000 ;%  400;    % Volume of reactor 1 (L)
V2 = 400  ;%  2000;   % Volume of reactor 2 (L)
k = 1.5;     % Reaction rate constant (L/(mol·h))

% Steady-state concentrations
Cw1s = 0.3333; % Reactor 1 steady-state concentration (mol/L)
Cw2s = 0.09005; % Reactor 2 steady-state concentration (mol/L)
Cwin = 1;       % Inlet concentration (mol/L)

% Time span
tspan = [0 50]; % Simulate for 50 hours

% Initial conditions (steady-state concentrations)
C0 = [Cw1s; Cw2s];

% Solve nonlinear system using ode45
[t_nl, C_nl] = ode45(@(t, C) nonlinear_reactor(t, C, F_new, V1, V2, k, Cwin), tspan, C0);

% Compute A and B matrices at steady-state
% A = [-F0/V1 - 2*k*Cw1s,  F0/V1; 
%       F0/V2, -F0/V2 - 2*k*Cw2s];
% 
% B = [1/V1, 0; 
%      0,    0];
A = [-F0/V1 - 2*k*Cw1s,  0; 
      F0/V2, -F0/V2 - 2*k*Cw2s];

B = [(Cwin-Cw1s)/V1, F0/V1; 
     (Cw1s-Cw2s)/V2,    0];

% Solve linearized system using ode45
x0 = [0; 0]; % Deviation variables start at zero
[t_lin, x_lin] = ode45(@(t, x) A * x + B * [(F_new - F0); 0], tspan, x0);

% Convert linearized deviation variables back to physical concentrations
C_lin = x_lin + [Cw1s, Cw2s];

% Plot results
figure;
subplot(2,1,1);
plot(t_nl, C_nl(:,1), 'b:', 'LineWidth', 1.5); hold on;
plot(t_lin, C_lin(:,1), 'r:', 'LineWidth', 1.5);
xlabel('Time (h)');
ylabel('C_{w1} (mol/L)');
legend('Nonlinear', 'Linearized');
title('Reactor 1 Concentration Response');

subplot(2,1,2);
plot(t_nl, C_nl(:,2), 'b:', 'LineWidth', 1.5); hold on;
plot(t_lin, C_lin(:,2), 'r:', 'LineWidth', 1.5);
xlabel('Time (h)');
ylabel('C_{w2} (mol/L)');
legend('Nonlinear', 'Linearized');
title('Reactor 2 Concentration Response');

grid on;

% Check if removal specification is still met
final_Cw2_nl = C_nl(end,2);
removal_nl = (1 - final_Cw2_nl) * 100; % Percentage removal
disp(['Final nonlinear Cw2: ', num2str(final_Cw2_nl)]);
disp(['Nonlinear removal efficiency: ', num2str(removal_nl), '%']);

% Function for nonlinear reactor ODEs
function dCdt = nonlinear_reactor(~, C, F, V1, V2, k, Cwin)
    Cw1 = C(1);
    Cw2 = C(2);
    
    dCw1dt = (F/V1) * (Cwin - Cw1) - k * Cw1^2;
    dCw2dt = (F/V2) * (Cw1 - Cw2) - k * Cw2^2;
    
    dCdt = [dCw1dt; dCw2dt];
end
