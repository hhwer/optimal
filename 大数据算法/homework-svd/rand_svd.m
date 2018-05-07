function [ U,S,V,t ] = rand_svd( A,c,k,method )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
tic
if method == 1
    H = monte_carlo( A,c,k );
else
    H= rand_rangefinder(A,c,k);
end
t = toc;

Y = H'*A;
Y = Y';
[V,S,W] = svd(Y,0);
U = H*W;
end

