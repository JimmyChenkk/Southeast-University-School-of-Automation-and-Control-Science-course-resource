clc,clear,close all
%% 4-1
a1 = [1.0];
b1 = [0.2, 1];
a2 = [2.0];
b2 = [0.094, 1];
a3 = [5.1];
b3 = [0.051, 1];
objectivesysa = conv(a1, a2);
objectivesysa = conv(objectivesysa, a3);
objectivesysb = conv(b1, b2);
objectivesysb = conv(objectivesysb, b3);
objectivesys = tf(objectivesysa, objectivesysb);
figure;
bode(objectivesys);
% grid on;
legend('原系统');
%% 4-2
sys4_2 = tf([1], [0.2, 1]);
objectivesysb4_2 = conv(objectivesysb, [0.2, 1]);
objectivesys4_2 = tf(objectivesysa, objectivesysb4_2);
figure;
bode(objectivesys, sys4_2, objectivesys4_2);
legend('原系统', '校正环节', '校正后系统');
%% 4-3
sys4_3 = tf([1], [4, 1]);
objectivesysb4_3 = conv(objectivesysb, [4, 1]);
objectivesys4_3 = tf(objectivesysa, objectivesysb4_3);
figure;
bode(objectivesys, sys4_3, objectivesys4_3);
legend('原系统', '校正环节', '校正后系统');
%% 4-4
sys4_4 = tf([0.1, 1],[1]);
objectivesysa4_4 = conv(objectivesysa, [0.1, 1]);
objectivesys4_4 = tf(objectivesysa4_4, objectivesysb);
figure;
bode(objectivesys, sys4_4, objectivesys4_4);
legend('原系统', '校正环节', '校正后系统');
%% 4-5
sys4_5 = tf([0.02, 0.3, 1],[0.2,0]);
objectivesysa4_5 = conv(objectivesysa, [0.02, 0.3, 1]);
objectivesysb4_5 = conv(objectivesysb, [0.2, 0]);
objectivesys4_5 = tf(objectivesysa4_5, objectivesysb4_5);
figure;
bode(objectivesys, sys4_5, objectivesys4_5);
legend('原系统', '校正环节', '校正后系统');