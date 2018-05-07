function [x,result] = l1_admm(x0, A, b, opts5);
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
[m,n] = size(A);
beta = 2*m/norm(b,1);
x = x0;
epsilon = 1e-8;
y = zeros(m,1);
MAX = 10000;
k = 0;
Q = (A*A')^(-1);
rp = A*x-b;
Ay = A'*y;
while k < MAX
    z = Ay + x/beta;
    z(z>1) = 1;
    z(z<-1) = -1;
%     g = A*x-b+beta*A*(A'*y-z);
%     g1 = A'*g;
%     alpha = (g'*g)/(g1'*g1);
%     y = y - alpha*g;
    y = Q*(A*z-rp/beta);
    Ay = A'*y;
    rd = Ay-z;    
    x1 = x + beta*rd;
    rp = A*x1-b;
    fp = norm(x1,1);
    delta = b'*y - fp;
    if max([norm(rp)/norm(b),norm(rd)/sqrt(m),abs(delta)/fp])<epsilon
        break
    end
    x = x1;
    k = k+1;
end
result = k;
end