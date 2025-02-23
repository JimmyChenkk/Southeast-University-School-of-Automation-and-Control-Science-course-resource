clc
clear

% 生产线、规格、材料和班次
lines = 1:5;              % 生产线编号l=1~5
specs = 1:5;              % 规格编号s=1~5[5.5,8,10,13.5,14]5种
mats = 1:3;               % 材料编号m=1~3材料三种
periods = 1:12;           % 班次编号t=1~12

% 创建 HotRollingModel 类的实例
model = HotRollingModel(lines, specs, mats, periods);

% 设置模型的参数：需求、生产能力、库存成本、罚款成本
Demand = zeros(5, 3, 2);            % 需求矩阵，5个规格，3种材料，2部分需求
ProdLimits = zeros(5, 3, 5);        % 生产能力矩阵，5个规格，3种材料，5条生产线
HoldCost = zeros(5, 3);             % 库存成本矩阵，5个规格，3种材料
PenaltyCost = zeros(5, 3);          % 罚款成本矩阵，5个规格，3种材料

hold = 10;
penalty = 100;

% 固定题给条件
Demand(1,2,1)=500;
Demand(2,2,1)=800;
Demand(2,3,1)=600;
Demand(3,3,1)=650;
Demand(4,1,1)=1200;
Demand(4,2,2)=1200;
Demand(5,1,2)=450;
Demand(5,2,2)=750;

%自定义3种参数：生产能力、库存成本、罚款成本
HoldCost(1,2)=hold;
HoldCost(2,2)=hold;
HoldCost(2,3)=hold;
HoldCost(3,3)=hold;
HoldCost(4,1)=hold;
HoldCost(4,2)=hold;
HoldCost(5,1)=hold;
HoldCost(5,2)=hold;


% PenaltyCost(1,2)=100000000000;
% PenaltyCost(2,2)=100000000000;
% PenaltyCost(2,3)=100000000000;
% PenaltyCost(3,3)=100000000000;
% PenaltyCost(4,1)=100000000000;
% PenaltyCost(4,2)=100000000000;
% PenaltyCost(5,1)=100000000000;
% PenaltyCost(5,2)=100000000000;
PenaltyCost(1,2)=penalty;
PenaltyCost(2,2)=penalty;
PenaltyCost(2,3)=penalty;
PenaltyCost(3,3)=penalty;
PenaltyCost(4,1)=penalty;
PenaltyCost(4,2)=penalty;
PenaltyCost(5,1)=penalty;
PenaltyCost(5,2)=penalty;

pl = 75;
ProdLimits(1,2,1)=pl;
ProdLimits(2,2,1)=pl;
ProdLimits(2,3,1)=pl;
ProdLimits(3,3,1)=pl;
ProdLimits(4,1,1)=pl;
ProdLimits(4,2,1)=pl;
ProdLimits(5,1,1)=pl;
ProdLimits(5,2,1)=pl;
ProdLimits(1,2,2)=pl;
ProdLimits(2,2,2)=pl;
ProdLimits(2,3,2)=pl;
ProdLimits(3,3,2)=pl;
ProdLimits(4,1,2)=pl;
ProdLimits(4,2,2)=pl;
ProdLimits(5,1,2)=pl;
ProdLimits(5,2,2)=pl;
ProdLimits(1,2,3)=pl;
ProdLimits(2,2,3)=pl;
ProdLimits(2,3,3)=pl;
ProdLimits(3,3,3)=pl;
ProdLimits(4,1,3)=pl;
ProdLimits(4,2,3)=pl;
ProdLimits(5,1,3)=pl;
ProdLimits(5,2,3)=pl;
ProdLimits(1,2,4)=pl;
ProdLimits(2,2,4)=pl;
ProdLimits(2,3,4)=pl;
ProdLimits(3,3,4)=pl;
ProdLimits(4,1,4)=pl;
ProdLimits(4,2,4)=pl;
ProdLimits(5,1,4)=pl;
ProdLimits(5,2,4)=pl;
ProdLimits(1,2,5)=pl;
ProdLimits(2,2,5)=pl;
ProdLimits(2,3,5)=pl;
ProdLimits(3,3,5)=pl;
ProdLimits(4,1,5)=pl;
ProdLimits(4,2,5)=pl;
ProdLimits(5,1,5)=pl;
ProdLimits(5,2,5)=pl;
% 设置模型参数，传递给实例的成员
model.setParameters(Demand, ProdLimits, HoldCost, PenaltyCost);

% 求解优化问题
[X_opt, fval] = model.solve_optimization();

% 输出优化后的生产计划和目标函数值
disp('优化后的生产计划：');
disp(X_opt);

disp('优化后的目标函数值：');
disp(fval);

disp("-----------------")
% 求解优化问题
[X_opt1, fval1] = model.opt();

% 输出优化后的生产计划和目标函数值
disp('优化后的生产计划：');
disp(X_opt1);

disp('优化后的目标函数值：');
disp(fval1);
