function [ F,g ] = ObjFunc_Rosenbrock( x )
%UNTITLED14 此处显示有关此函数的摘要
%   此处显示详细说明
F = Rosenbrock(x);
g = grid_Rosenbrock(x);

end

