function [ f,g ] = S303( x )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
n = length(x);
r = x.*([1:n]')/2;
t = r.^2;
f = x'*x + r'*r+ t'*t;
if nargout > 1
    g = 2*x+r.*([1:n]')+2*r.^3.*([1:n]');
end
    

end

