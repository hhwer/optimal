function [ out ] = eta( x,rho )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[n,~]=size(x);
out = sign(x).*max(abs(x)-rho,0);
end

