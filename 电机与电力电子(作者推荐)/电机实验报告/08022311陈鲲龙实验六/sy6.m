clc,clear
% 输入角度数据（单位：度）
angles_deg = [39.6, 46.8, 82.8, 111.6, 144]; % 角度列表
% 将角度从度转换为弧度
angles_rad = deg2rad(angles_deg);
% 计算公式结果
results = 0.45*70*(1+cos(angles_rad))*0.5;
% 实验实际结果
syresults = [28,25,19,10,2]; % 角度列表
% 显示结果
disp('角度（度）：');
disp(angles_deg);
disp('计算结果：');
disp(results);
disp('实验结果：');
disp(syresults);



