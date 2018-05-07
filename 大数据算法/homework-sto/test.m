function [ x1,x2,x3,t1,t2,t3,lossf1,lossf2,lossf3 ] = test( a,b,lambda,alpha,m,K )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
[n,p] = size(a);
hatx0 = zeros(1,p);
tic
[x1,lossf1] = sag( a,b,hatx0,lambda,alpha);
t1 = toc;

tic
[x2,lossf2] = svrg( a,b,hatx0,lambda,alpha,m);
t2 = toc;

if K == 3
    tic
    [x3,lossf3] = sgBB( a,b,hatx0,lambda,alpha);
    t3 = toc;
else 
    x3 = 0;
    lossf3 = 0;
    t3 = 0;
end
end

