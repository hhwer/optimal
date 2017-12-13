function [ x0,g0,f0,fevaall,i ] = L_SR1( Objfun,func,x0,m,K,Rule,epi)
%UNTITLED2 利用L_SR1进行拟NEWTON迭代
%   input
%   Objfun      Function_handle  [f,g,G]=Objfun(x) 为梯度以及hessen矩阵
%   func          Function_handle   [f] = func(x)    函数
%   x0             n_vector     初始点
%   m              int              存储长度
%   K               int           K==0 以I为B   
%                                   K==1加上scaling    rho*I
%                                     rho=s_{k-1}y_{k-1}/y_{k-1}y_{k-1}
%   epi            scalar         终止条件
if nargin < 7
    epi = 1e-8;
end
% Rule.opt = 2;
fevaall = 0;
% for i =1:10
%     [f0,g0,G] = Objfun(x0);
%     d = -G\g0;
%     x0= x0 + d;
% end
[f0,g0] = Objfun(x0);
d = -g0;
Q = [];
Ms = [];
My = [];
M = [];
S = [];
Y = [];
L=[];
U=[];
alpha = 1;
rho = 1;
for i = 1:100000
     [alpha,feva] = linesearch(func, x0,f0,g0, d, Rule);
     fevaall = fevaall + feva;
    x1 = x0+alpha*d;
    [f1,g1] = Objfun(x1);
    s = x1-x0;
    y = g1-g0;
    if K == 0
        [ Q,M,L,U ] = Updata( Q,M,L,U,s,y,m);
    else
        rho = s'*y/(y'*y);
        if i == 1
            rho = 2*rho;
        end
        [Q,S,Y,Ms,My,L,U] = Updata_new( Q,S,Y,Ms,My,L,U,s,y,m,rho);
    end
    d = H_sr1(Q,L,U,g1,rho);
%     d = d/norm(d);
%     disp(i)
%     [alpha,feva] = linesearch(func, x1,f1,g1, d, Rule);
    if abs(f1-f0)<1e-8;
        break;
    end
    x0 = x1;
    g0 = g1;
    f0 = f1
end
