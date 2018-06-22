function [ x1,x2,x3,x4,x5,t1,t2,t3,t4,t5,lossf1,lossf2,lossf3,lossf4,lossf5 ] = test( a,b,lambda,alpha,K )
%   此处显示详细说明   
%   admin   alpha = 0.0001;
[p,n] = size(a);
hatx0 = zeros(p,1);
tic
[x1,lossf1] = sag( a,b,hatx0,lambda,100*alpha,100,K);
t1 = toc;


if K ==  1
    eta = alpha * 1000;
else
    eta = alpha * 100;
end
tic
[x2,lossf2] = saga( a,b,hatx0,lambda,eta,100,K);
t2 = toc;


if K ==  1
    eta = alpha * 100;
else
    eta = alpha * 100;
end
tic
[x3,lossf3] = svrg( a,b,hatx0,lambda,eta,2*n,K);
t3 = toc;

tic
[x4,lossf4] = msvrg( a,b,hatx0,lambda,200*alpha,K);
t4 = toc;



tic
[x5,lossf5] = scsg( a,b,hatx0,lambda,100*alpha,K);
t5 = toc;
end

