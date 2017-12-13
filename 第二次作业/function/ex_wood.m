function [ f,g,G ] = ex_wood(x )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

n = length(x);
f = 0;
g = zeros(n,1);
[~ ,~ ,G1] = wood(x(1:4));
for i = 1:2:n-3
    [f1,g1] = wood(x(i:i+3));
    f = f+f1;
    g(i:i+3) = g(i:i+3)+g1;
end
if nargout > 2 
    G = zeros(n);
    for i = 1:2:n-3
        G(i:i+3,i:i+3) = G(i:i+3,i:i+3)+G1;
    end
end
end

