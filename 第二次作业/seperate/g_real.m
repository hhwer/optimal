function [g ] = g_real( Whole_g,index,n,N )
%UNTITLED6  返回梯度的范数
%   此处显示详细说明
g = zeros(n,1);
for i =1:N
    g(index{i}) = g(index{i})+Whole_g{i};
end
end

