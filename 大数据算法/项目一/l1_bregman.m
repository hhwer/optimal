function [x0,result] = l1_bregman(x0, A, b,  opts4);
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
[m,n] = size(A);
Q = A'*A;
bb = A'*b;
fk = b;
ite = 0;
mu = [10,1,0.1,0.01,0.001];
ep = [2e-4,1e-5,2e-6,1e-6,1e-6];
t = 1/norm(Q)*mu;
while ite<5
    k = 0;
    while k<5
        x0 = proxgrad(Q,A'*fk,t(k+1),mu(k+1),x0,ep(k+1));
        r = fk-A*x0;
        k = k+1;
    end
    if norm(r)/norm(b)<1e-8
        break
    end
    fk = b + r;
    ite = ite + 1;
end

result = ite;
end