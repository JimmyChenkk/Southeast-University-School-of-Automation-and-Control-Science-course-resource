clc; clear; close all;

% ===== 1. G(s) 系统定义 =====
numerator = 4;
denominator = [1 3 2 0];
G = tf(numerator, denominator);

% ===== 2. 定义 N(A)（间隙）描述函数 =====
K = 0.5;  % 放大倍数
b = 1;     % 间隙宽度

% 描述函数 N(A)
N = @(A) arrayfun(@(a) ...
    (abs(1 - 2*b/a) <= 1) * ...
    ((K/pi)*(pi/2 + asin(1 - 2*b/a) + 2*(1 - 2*b/a)*sqrt(b/a*(1 - b/a))) ...
     + 1i*(4*K/pi)*(b*(b - a)/a^2)), A);

% ===== 3. 扫描 A 和 w，计算误差 =====
A_vec = linspace(1.1*b, 100, 2000);  % 不能从 A=b 开始，要避开奇异点
w_vec = logspace(-1, 2, 500);

min_err = inf;
best_A = NaN; best_w = NaN;

for i = 1:length(A_vec)
    A = A_vec(i);
    NA = N(A);

    for j = 1:length(w_vec)
        w = w_vec(j);
        Gjw = evalfr(G, 1i*w);

        err = abs(Gjw + 1/NA);
        if err < min_err
            min_err = err;
            best_A = A;
            best_w = w;
            best_Gjw = Gjw;
        end
    end
end

% ===== 4. 输出结果 =====
fprintf('找到最小误差为 %.5f\n', min_err);
fprintf('对应振幅 A = %.3f, 频率 w = %.3f\n', best_A, best_w);
fprintf('对应 G(jw) = %.3f %+.3fi\n', real(best_Gjw), imag(best_Gjw));

% ===== 5. 可视化验证 =====
[Re, Im] = nyquist(G, w_vec);
Re = squeeze(Re); Im = squeeze(Im);
inv_N = -1 ./ N(A_vec);

figure;
plot(Re, Im, 'r', 'LineWidth', 1.2); hold on;
plot(real(inv_N), imag(inv_N), 'b', 'LineWidth', 2);

% ==== 标记 Nyquist G(jw) 起点/终点 ====
plot(Re(1), Im(1), 'ro', 'MarkerSize', 8, 'LineWidth', 1.5);
text(Re(1), Im(1), sprintf('  ω=%.2f (起点)', w_vec(1)), 'Color', 'r');

plot(Re(end), Im(end), 'rs', 'MarkerSize', 8, 'LineWidth', 1.5);
text(Re(end), Im(end), sprintf('  ω=%.2f (终点)', w_vec(end)), 'Color', 'r');

% ==== 标记 -1/N(A) 起点/终点 ====
plot(real(inv_N(1)), imag(inv_N(1)), 'bo', 'MarkerSize', 8, 'LineWidth', 1.5);
text(real(inv_N(1)), imag(inv_N(1)), sprintf('  A=%.2f (起点)', A_vec(1)), 'Color', 'b');

plot(real(inv_N(end)), imag(inv_N(end)), 'bs', 'MarkerSize', 8, 'LineWidth', 1.5);
text(real(inv_N(end)), imag(inv_N(end)), sprintf('  A=%.2f (终点)', A_vec(end)), 'Color', 'b');

% ==== 标记最小误差点 ====
plot(real(best_Gjw), imag(best_Gjw), 'kp', 'MarkerSize', 10, 'LineWidth', 2);
text(real(best_Gjw), imag(best_Gjw), sprintf('  最小误差点\n  A=%.2f, ω=%.2f', best_A, best_w), ...
     'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');

grid on;
xlabel('Re'); ylabel('Im');
legend('Nyquist G(s)', '-1/N(A)', 'G 起点', 'G 终点', 'N 起点', 'N 终点', '最小误差点', ...
       'Location', 'Best');
title('自动寻找自激振荡点并标注曲线端点');


