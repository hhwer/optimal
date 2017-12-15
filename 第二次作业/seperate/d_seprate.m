function [ d ] = d_seprate( Whole_H,Whole_g,index,n,N)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
% Whole_d = cell(N,1);
d = zeros(n,1);
for i = 1:N
    H = Whole_H{i};
    g = Whole_g{i};
    d([index{i}])  = d([index{i}]) -H*g;
end

end

