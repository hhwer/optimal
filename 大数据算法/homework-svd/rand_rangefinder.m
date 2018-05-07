function [ Q ] = rand_rangefinder(A,c,k);
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
[~,n] = size(A);

Omega = randn(n,c);
Y = A*Omega;
% [Q,~] = qr(Y);
[Q,~] = svd(Y,0);
Q = Q(:,1:k);

end
