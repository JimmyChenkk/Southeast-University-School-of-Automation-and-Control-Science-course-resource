clc,clear
% 输入角度数据（单位：度）
angles_deg = [93.6,97.2,115.2,129.6]; % 角度列表
% 将角度从度转换为弧度
angles_rad = deg2rad(angles_deg);
% 计算公式结果
results = 0.9*70*(1+cos(angles_rad))*0.5;
% 实验实际结果
syresults = [39,32,22,14]; 
% 显示结果
disp('角度（度）：');
disp(angles_deg);
disp('计算结果：');
disp(results);
disp('实验结果：');
disp(syresults);



