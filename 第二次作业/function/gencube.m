function [ f,g ] = gencube(x)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
n = length(x);
r = zeros(n,1);
r(1) = (x(1)-1);
for i = 2:n
    r(i) = 10*(x(i)-x(i-1)^3);
end
f = r'*r;
if nargout >=1
    g = zeros(n,1);
    g(1) = 2*r(1);
    for i = 2:n
        g(i) = 20*r(i);
        g(i-1) = g(i-1) - 60*r(i)*x(i-1)^2;
    end
end

end

