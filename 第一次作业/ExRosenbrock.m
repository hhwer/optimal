function [ s ] = ExRosenbrock( x )
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
m = size(x);
m = m(1);
s = 0;
n = m/2;
for i = 1:n
    r1 = 10*(x(2*i)-x(2*i-1)^2);
    r2 = 1 - x(2*i-1);
    s = s + r1^2 + r2^2;
end