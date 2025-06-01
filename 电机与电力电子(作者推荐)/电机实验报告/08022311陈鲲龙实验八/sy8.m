clc,clear
% 输入角度数据（单位：度）
angles_deg = [46.8,64.8,90,104.4,133.2]; % 角度列表
% 将角度从度转换为弧度
angles_rad = deg2rad(angles_deg);
% 计算公式结果
results = 70*sqrt(sin(2*angles_rad)/(2*pi)+(pi-angles_rad)/pi);
% 实验实际结果
syresults = [60,49,38,27,11]; 
% 显示结果
disp('角度（度）：');
disp(angles_deg);
disp('计算结果：');
disp(results);
disp('实验结果：');
disp(syresults);



