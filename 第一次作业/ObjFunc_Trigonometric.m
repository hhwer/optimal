function [ F,g,G ] = ObjFunc_Trigonometric( x )
%UNTITLED14 此处显示有关此函数的摘要
%   此处显示详细说明
F = Trigonometric(x);
g = grid_Trigonometric(x);
G = Hessen_Trigonometric(x);
end