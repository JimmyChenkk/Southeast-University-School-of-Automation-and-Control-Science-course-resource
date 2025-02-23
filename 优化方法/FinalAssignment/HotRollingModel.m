classdef HotRollingModel < handle % 省略handle无法引用传递
    properties
        Lines          % 生产线编号l=1~5                       %生产线数量l=5
        Specifications % 规格编号s=1~5[5.5,8,10,13.5,14]5种    %规格数量s=5
        Materials      % 材料编号m=1~3材料三种                  %材料数量m=3
        Periods        % 班次编号t=1~12                       %班次数量t=12
        Demand         % 每种规格和材料的需求矩阵 维度(s*m*2)
        ProdLimits     % 每条生产线每种规格和材料的最大产能 维度(s*m*l)
        HoldCost       % 每种规格和材料的库存成本矩阵 维度(s*m)
        PenaltyCost    % 每种规格和材料的未满足需求单位罚款矩阵 维度(s*m)
        Xsmlt          % 每个班次中每条生产线每种规格和材料的实际生产量即所需优化的变量(s*m*l*t)
        % 以下为标准形式min w'x s.t. Ax≤b系数，其中x'=(x1,……，xlsmt,y1,……,ysm)
        w
        A
        b
        lb
        ub
    end

    methods
        function obj = HotRollingModel(lines, specs, mats, periods)
            % 构造函数
            obj.Lines = lines;
            obj.Specifications = specs;
            obj.Materials = mats;
            obj.Periods = periods;
            l=size(lines,2);%生产线数量l=5
            s=size(specs,2);%规格数量s=5
            m=size(mats,2);%材料数量m=3
            t=size(periods,2);%班次数量t=12
            obj.Demand = zeros(s,m,2);
            obj.ProdLimits = zeros(s,m,l);
            obj.HoldCost = zeros(s,m);
            obj.PenaltyCost = zeros(s,m);
            obj.Xsmlt= zeros(s,m,l,t);
            obj.w = zeros(s*m*l*t+s*m,1);
            obj.A = zeros(s*m,s*m*l*t+s*m);
            obj.b = zeros(s*m*l*t+s*m,1);
            obj.lb = zeros(s*m*l*t+s*m,1);
            obj.ub = zeros(s*m*l*t+s*m,1);
        end

        function obj = setParameters(obj, demand, prodLimits, holdCost, penaltyCost)
            periods = obj.Periods;
            obj.Demand = demand;
            obj.ProdLimits = prodLimits;
            obj.HoldCost = holdCost;
            obj.PenaltyCost = penaltyCost;

            obj.Simplfy(); % 化简问题
        end

        % 目标函数的定义
        function K = objective_function(obj, X_flat)%, Demand, HoldCost, PenaltyCost)
            [S, M, L, T] = size(obj.Xsmlt);  % 获取维度
            X = reshape(X_flat, S, M, L, T);  % 将一维数组恢复为四维矩阵

            % 初始化中间变量
            e1 = zeros(S, M);
            e2 = zeros(S, M);
            K = 0;

            % 计算 d1 和 d2
            d1 = obj.Demand(:,:,1) > 0;%体现需求(ddl=10)的0-1阵
            d2 = obj.Demand(:,:,2) > 0;%体现需求(ddl=12)的0-1阵

            % 计算 g1:需求(ddl=10)的库存成本
            for t = 1:10
                for l = 1:5
                    K = K + sum((10 - t) .* X(:,:,l,t) .* d1 .* obj.HoldCost(:,:),'all');
                end
            end

            % 计算 g2:需求(ddl=12)的库存成本
            for t = 1:12
                for l = 1:5
                    K = K + sum((12 - t) .* X(:,:,l,t) .* d2 .* obj.HoldCost(:,:),'all');
                end
            end

            % 计算 e1 和 e2:需求(ddl=10)&需求(ddl=12)的累计生产量
            for t = 1:10
                for l = 1:5
                    e1 = e1 + X(:,:,l,t);
                end
            end
            for t = 1:12
                for l = 1:5
                    e2 = e2 + X(:,:,l,t);
                end
            end

            % 计算需求(ddl=10)&需求(ddl=12)的未满足需求罚款总数
            penalty1 = sum(max((obj.Demand(:,:,1) - e1 .* d1), 0) .* obj.PenaltyCost(:,:), 'all');
            penalty2 = sum(max((obj.Demand(:,:,2) - e2 .* d2), 0) .* obj.PenaltyCost(:,:), 'all');
            K = K + penalty1 + penalty2;
        end

        % 约束条件（ProdLimits）
        function [c, ceq] = constraints(obj, X_flat)%, ProdLimits)
            [S, M, L, T] = size(obj.Xsmlt);  % 获取 ProdLimits 的维度
            X = reshape(X_flat, S, M, L, T);  % 将一维数组恢复为四维矩阵

            % 约束：X 中的每个元素都小于等于相应位置的 ProdLimits 元素
            c = [];  % 没有等式约束
            ceq = [];  % 没有等式约束

            for t = 1:T
                for l = 1:L
                    c = [c; X(:,:,l,t) - obj.ProdLimits(:,:,l)];  % 不等式约束：X <= ProdLimits
                end
            end
        end

        function [] = Simplfy(obj)
            % 原函数化简形式
            % f = ∑∑∑hsm∑∑(13-t)Xlsmt+max(D12sm-∑∑Xlsmt,0)+max(D10sm-∑∑Xlsmt,0)
            [S, M, L, T] = size(obj.Xsmlt);
            % 化简第一部分（存储）
            % 计算系数w1=hsm^l^t*（13-t）
            w1 = zeros(S,M,L,T);
            for l = 1:L
                for t = 1:T
                    w1(:,:,l,t) = obj.HoldCost*(13-t);
                end
            end
            % 展平成列向量
            w1_flat = reshape(w1, [], 1);
            % 罚款会带来第二部分辅助变量系数(y1-ysm)，系数为s规格m材料罚款【见下】
            w_added = ones(S*M,1);
            for s = 1:S
                for m = 1:M
                    w_added(s*m) = obj.PenaltyCost(s,m);
                end
            end
            w1_flat = [w1_flat;w_added];
            obj.w = w1_flat;

            % 化简第二部分（罚款）
            % s/m种钢材ddl所在时刻，s*m个约束，max{Dsm-∑∑Xlsmt,0}
            % min(max{g_sm(x),0})线性化简：min(y1),y1≥g_sm(x) -> -x1-x……-y1≤d,y1≥0
            % g_sm(x)=Dsm-∑∑Xsmlt
            % 计算x的系数
            g_sm_x = zeros(S*M,S,M,L,T); 
            for s = 1:S
                for m = 1:M
                    % 第10天部分
                    if obj.Demand(s,m,1) > 0
                        for t = 1:10
                            g_sm_x(s*m,s,m,:,t) = -1;
                        end
                    end
                    % 12天部分
                    if obj.Demand(s,m,2) > 0
                        for t = 1:12
                            g_sm_x(s*m,s,m,:,t) = -1;
                        end
                    end
                end
            end
            % 展平
            g_sm_x_flat = zeros(S*M,S*M*L*T);
            for s = 1:S
                for m = 1:M
                    % temp=reshape(g_sm_x(s*m,:,:,:,:), [], 1);
                    g_sm_x_flat(s*m,:) = reshape(g_sm_x(s*m,:,:,:,:), [], 1);
                end
            end
            % 辅助变量y系数
            g_sm_y = eye(S*M)*-1;
            % 约束条件系数
            g_sm = [g_sm_x_flat,g_sm_y];
            % 约束条件常数项（-1*需求）
            g_sm_b = zeros(S*M,1);
            for s = 1:S
                for m = 1:M
                    g_sm_b(s*m) = -obj.Demand(s,m,1)-obj.Demand(s,m,2);
                end
            end

            obj.A = g_sm;
            obj.b = g_sm_b;


            % 这样就变成了标准形式min w'x s.t. Ax≤b，其中x'=(x1,……，xlsmt,y1,……,ysm)
            expand_ProdLimits = zeros(S,M,L,T);
            for t = 1:T
                expand_ProdLimits(:,:,:,t) = obj.ProdLimits;
            end
            ub_x = reshape(expand_ProdLimits, [], 1);
            ub_y = zeros(S*M,1);
            for s = 1:S
                for m = 1:M
                    ub_y(s*m) = obj.Demand(s,m,1)+obj.Demand(s,m,2);
                end
            end
            obj.ub = [ub_x;ub_y];
        end

        function [X_opt, fval] = opt(obj)
            [X_opt_flat,fval] = linprog(obj.w,obj.A,obj.b,[],[],obj.lb,obj.ub);
            [S, M, L, T] = size(obj.Xsmlt);
            X_opt = reshape(X_opt_flat(1:S*M*L*T),S,M,L,T);
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%各种/类优化方法具体实现函数
        % 设置优化问题并调用 fmincon
        function [X_opt, fval] = solve_optimization(obj)
            % 初始化变量和参数
            [S, M, L, T] = size(obj.Xsmlt);  % 获取 Demand 的维度
            X0 = 10*ones(S, M, L, T);  % 初始猜测值，随机初始化
            X0 = X0.*[0,1,0;0,1,1;0,0,1;1,1,0;1,1,0];

            % 将 X0 展平为一维数组
            X0_flat = X0(:);

            % 目标函数
            objective_function_handle = @(X_flat) obj.objective_function(X0_flat);%, obj.Demand, obj.HoldCost, obj.PenaltyCost);

            % 变量上下界（假设 X 的值在 [0, 1] 之间）
            lb = zeros(S * M * L * T, 1);  % 下界
            ub = [];%ones(S * M * L * T, 1);   % 上界

            % 约束条件
            nonlincon = @(X_flat) obj.constraints(X0_flat);%, obj.ProdLimits);  % 非线性约束

            % 设置 fmincon 选项
            options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');

            % 调用 fmincon 进行优化
            [X_opt_flat, fval] = fmincon(objective_function_handle, X0_flat, [], [], [], [], lb, ub, nonlincon, options);

            % 将优化结果 X_opt_flat 重新恢复为原始维度
            X_opt = reshape(X_opt_flat, S, M, L, T);
        end
    end
end