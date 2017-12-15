function [ F,g ] = ObjFunc_ExRosenbrock( x )
%UNTITLED14 此处显示有关此函数的摘要
%   此处显示详细说明
F = ExRosenbrock(x);
g = grid_ExRosenbrock(x);

end