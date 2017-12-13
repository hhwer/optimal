function [ y ] = Br_bfgs( vectorA,vectorB,x )
%UNTITLED   compute  B'*r
%   此处显示详细说明
%   input 
%       vectorA = [a_{k-m},...,a_{k-1}] 
%       vectorB = [b_{k-m},...,b_{k-1}]



% [~,m] = size(vectorA);
% y = x;
% for i =1:m
%     y = vectorB(i)*(vectorB(i)'*x) - vectorA(i)*(vectorA(i)'x);
y = x + vectorB*(vectorB'*x) - vectorA*(vectorA'*x);
end