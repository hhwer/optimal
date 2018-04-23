function [ out ] = Q( x,y,y_inverse,zeta,S )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
out = -log(det(y)) + trace(S*y)+trace((x-y)*(S-y_inverse)) + 1/2/zeta*norm(x-y,'fro')^2;
end

