%08022311
clc
clear
% a=[1,0,1;0,1,1];% 输入布尔矩阵
% b=[1,0;0,1;1,1];
% output=booleanMultiply(a, b);% 函数调用
% display(a);
% display(b);
% display(output);% 输出布尔乘的结果
% function C = booleanMultiply(A, B)% 函数定义
% % A 和 B 是输入布尔矩阵
% % C 是输出布尔乘的结果
% [m, n] = size(A);
% [p, q] = size(B);
% if n ~= p
%     error('矩阵维度不匹配，无法进行布尔乘！');
% end
% % 初始化结果矩阵 C
% C = false(m, q);
% for i = 1:m
%     for j = 1:q
%         % 布尔乘
%         for k = 1:n
%             if A(i, k) && B(k, j)
%                 C(i, j) = true;
%                 break; % 如果已经为 true，则无需继续计算
%             end
%         end
%     end
% end
% end
a=[1,1,0;1,0,0;1,1,0];
b=a*a;