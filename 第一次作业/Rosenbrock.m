function [ output_args,J ] = Rosenbrock( x )
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
x1 = x(1);
x2 = x(2);
r1 = 10*(x2-x1^2);
r2 = 1 - x1;
output_args = r1^2 + r2^2;
output_args = [r1,r2]';
J = [-20*x1,-1;10,0]';
end

