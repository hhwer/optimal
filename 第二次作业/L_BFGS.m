function [ x0,g0,f0,fevaall,k,F] = L_BFGS( Objfun,func,x0,m,Rule,epi)
%UNTITLED2 利用L_BFGS进行拟NEWTON迭代
%   input
%   Objfun      Function_handle  [f,g,G]=Objfun(x) 为梯度以及hessen矩阵
%   grid          Function_handle   [g] = grid(x)    梯度
%   func          Fucnction_handle  [f]  = func(x)  函数值
%   x0             n_vector     初始点
%   m              int              存储长度
%   epi            scalar         终止条件
if nargin < 6
    epi = 1e-8;
end
F=[];
Rule.opt = 2; %%线搜索准则为armijo
MAX = 100000;
[f0,g0] = Objfun(x0);
F(1) = f0;
% d = -G\g0;
d = -g0;
% alpha = 1;
[alpha,feva] = linesearch(func, x0,f0,g0, d, Rule);
fevaall = feva;
x1 = x0+alpha*d;
[f1,g1] = Objfun(x1);
for i = 1:m
    S(:,i) = x1-x0;
    Y(:,i) = g1-g0;
    x0 = x1;
    g0 = g1;
    F(i) = f0;
    f0 = f1; 
    d = H_bfgs(S,Y,g1);
    [alpha,feva] = linesearch(func, x0,f0,g0, d, Rule);
    fevaall = fevaall + feva;
    x1 = x0 + alpha  * d;
    [f1,g1] = Objfun(x1);
end


for k = 1:MAX 
    S = S(:,2:m);
    Y = Y(:,2:m);
    S(:,m) = x1-x0;
    Y(:,m) = g1-g0;    
    x0 = x1;
    F(k+m)=f0;
    f0 = f1;
    g0 = g1;
    d = H_bfgs(S,Y,g1);
%     disp(k);
%     if norm(g1) < epi
%         break
%     end
    [alpha,feva] = linesearch(func, x0,f0,g0, d, Rule);
    fevaall = fevaall + feva;
    x1 = x0 + alpha  * d;
    [f1,g1] = Objfun(x1);
    if abs(f1-f0)<1e-8;
        break;
    end
    disp(f1)
end
disp(f1-f0);
end
