function [ s ] = Trigonometric( x)
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
s = 0;
n = size(x);
n = n(1);
for i = 1:n
    r = n + i*(1 - cos(x(i))) - sin(x(i));
    for j = 1:n 
        r = r - cos(x(j));
    end
    s = s + r^2;
end
end


