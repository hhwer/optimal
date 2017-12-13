function [x1, f0,k,t,ite,output] = Newton ( func, Objfun, x0, epi,status,Rule)
%UNTITLED3 此处显示有关此函数的摘要
%   intput
%   func    Function_handle  [F] = func(x);    目标函数
%   Objfun  Function_handle  [F,g,G] = func(x); 目标函数及一二阶导
%   x       n_vevtor    初始点
%   epi     scalar      终止条件
%   status  int   method 
%             status = 0 带步长牛顿
%             status = 1 修正牛顿
%             status = 2 曲线搜索
%   Rule    详见linesearch以及d_cholesky
%   
%output
%   x1    n_vector   终止点
%   f0    scalar     最终函数值
%   k     scalar     迭代步数
%   t     scalar     最后下降量
%   ite   scalar     迭代步数
%   output  k_vector 历史函数值

k = 0;
[f0,g0,G0] = Objfun(x0);
output(:,1) = f0;
ite = 1;
while k < 50000
    if status == 0
        d = -G0\g0;
        [al,feva] = linesearch(func, x0,g0 ,d, Rule);
        x1 = x0 + al*d;
    elseif status == 1
        d = d_cholesky(G0,g0,Rule.delta);
        [al,feva] = linesearch(func, x0,g0, d, Rule);
        x1 = x0 + al*d;
    else
        [x1,feva] = armijo(func,x0, G0,g0,Rule);
    end
    ite = ite + feva;
    [f1,g0,G0] = Objfun(x1);
    t = f1-f0;
    if abs(t) < epi
        break
    end
    x0 = x1;
    f0 = f1;
    k = k+1;
    output(k) = f0;
end
   
end

