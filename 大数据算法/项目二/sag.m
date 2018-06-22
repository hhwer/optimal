function [ x1,lossf ] = sag( a,b,x0,lambda,alpha,num,K)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   nΪf����,pΪxά��
%   a = matrix(n,p);  �����е�x1,x2,...,xn
%   b = vevtor(n);     �����е�y1,y2,...,yn
%   



[p,n] = size(a);
E = 10*n;
step = ceil(E/num);
lossf = zeros(p,num);
grady = zeros(p,n);   %%recent gradient of each component f
g=0;
for e = 1:E
    if  mod(e,step) == 1
        lossf(:,(e-1)/step+1) = x0;
    end
    sk = randperm(n,1);
    ex = exp(-b(sk)*x0'*a(:,sk));
    sigma = ex/(1+ex);
    if K == 1
        gradsk = lambda * sign(x0) - b(sk)*sigma*a(:,sk);
    elseif K == 2
        gradsk = lambda * 2 * x0 - b(sk)*sigma*a(:,sk);
    end
    g = g + (gradsk - grady(:,sk))/n;
    grady(:,sk) = gradsk;
    x1 = x0 - alpha*g;
    x0 = x1;
end
end