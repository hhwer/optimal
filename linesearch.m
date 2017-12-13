function [stepsize,feva] = linesearch(Func, Point,f0,g0, direction, Rule)
% linesearch 求解最优化问题 P: a = argmin f(x+a*d)
%
% 这个函数可以选择使用精确或非精确线性搜索求解问题。
% 精确线性搜索使用0.618方法求解;
% 非精确线性搜索可以选择Goldstein, Wolfe, 强Wolfe三种搜索准则，
% 使用两点二次插值法。
%
% Call
% [StepSize,err,feva] = linesearch(Func, Point, direction)
% [StepSize,err,feva] = linesearch(Func, Point, direction, Rule)
% 
% Input 
% Func:    function_handle, [F,g]=Func(x)
%                                       or   [F] = Func(x)
%                            F:函数值 g:梯度向量
% Point:      n-vector, 初始点x
% direction:  n-vector, 方向d
% f0           scalar    f(x0)
% g0          n_vector  梯度g
% Rule:       struct,线搜索的方法和准则
%    Rule.opt:1:精确线搜索，使用0.618方法 默认
%             2:非精确线搜索 1阶armijo准则
%               3:线精确 不下降则非精确
%    Rule.rho:判断准则中的rho  默认0.01
%    Rule.nu   底数nu          默认0.8
%             
%   
% Output
% stepsize: scalar,问题P的解,线搜索结果 
% feva:      scalar,函数调用次数
%

Tercond = 1e-8;


Max = 400;   %最大循环次数
feva = 0;
if Rule.opt == 1     %判断线搜索的方法和准则
    [stepsize,feva] = dot618(Func,Point,direction,Tercond);
    
elseif Rule.opt == 2
    if ~isfield(Rule,'rho')
        Rule.rho = 0.1;
    end
    if ~isfield(Rule,'nu')
        Rule.nu = 0.9;
    end
    u  = Rule.rho *  g0' * direction;
    t = 1;
    if u > 0
%         u = -u;
        t = -1;
    end
    i = 0;
    while 1
       x1 = Point + t*direction;
       f1 = Func(x1);
       feva = feva+1;
       if f1 <= f0 + u*t
           stepsize = t;
           break
       elseif i > Max
           stepsize = t;
           break
       end
       t = t  * Rule.nu;
       i = i + 1;
    end
    
else
    if ~isfield(Rule,'rho')
        Rule.rho = 0.01;
    end
    if ~isfield(Rule,'nu')
        Rule.nu = 0.8;
    end
    u  = Rule.rho * g0' * direction;
    t = 1;
    if u > 0
        %         u = -u;
        t = -1;
    end
    i = 0;
    while 1
        x1 = Point + t*direction;
        f1 = Func(x1);
        feva = feva+1;
        if f1 <= f0 + u*t
            stepsize = t;
            break
        elseif i > Max
            
            [stepsize,feva,situation] = dot618(Func,Point,direction,Tercond);
            if situation == 1
                return
            else
                stepsize = t;
                break
            end
        end
    t = t  * Rule.nu;
    i = i + 1;
    end
end
end




