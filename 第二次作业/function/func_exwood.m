function [ f ] = func_exwood( x )
%UNTITLED3 extendwood����ֵ
%   �˴���ʾ��ϸ˵��
n = length(x);
f = 0;
for i = 1:2:n-3
    f = f+func_wood(x(i:i+3));
end
end

