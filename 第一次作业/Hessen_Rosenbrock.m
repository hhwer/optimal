function [ c ] = Hessen_Rosenbrock( x )
%UNTITLED9 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
x1 = x(1);
x2 = x(2);
c = zeros(2);
c(1,1) = 1200*x1^2 - 400*x2 + 1;
c(2,2) = 100;
c(1,2) = -400*x1;
c(2,1) = c(1,2);
end

