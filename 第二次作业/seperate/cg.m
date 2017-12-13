function [ x ] = cg( Whole_B,g_REAL,d,index,n,N )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
k = 0;
epi = 1e-6;
x = ones(n,1);
% r = g_REAL - Br_seperate(Whole_B,x,index,n,N);
r = g_REAL - Whole_B*x;
beta = norm(r);
q1 = 0;
c1 = 0;
while beta > epi;
    q2 = r/beta;
    k = k+1;
%     z = Br_seperate(Whole_B,q2,index,n,N);
    z = Whole_B *q2;
    alpha = q2'*z;
    if k == 1
        d = alpha;
        v = beta/d;
        c = q2;
    else
        l = beta/d;
        d = alpha - beta*l;
        v = -beta*v/d;
        c = q2 - l*c;
    end
    x = x + v*c;
    r = z - alpha*q2 - beta*q1;
    beta = norm(r);
    q1 = q2;
end
x = -x;
end

