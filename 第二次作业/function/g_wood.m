function [ Whole_g ] = g_wood( x,n )
%UNTITLED7 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
N = n/2 - 1;
Whole_g = cell(N,1);
for i = 1:N
    [~,Whole_g{i}] = wood(x(2*i-1:2*i+2));
end
end

