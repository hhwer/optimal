function [ output_args ] = grid_Rosenbrock( x )
%UNTITLED8 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
x1 = x(1);
x2 = x(2);
r1 = 10*(x2-x1^2);
r2 = 1 - x1;
output_args(1) = -2*r1*20*x1 - 2*r2;
output_args(2) = 2*r1*10;
output_args = output_args';
end

