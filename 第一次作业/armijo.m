function [ x1,i ] = armijo(F,x0, G,g,Rule)
%UNTITLED2 2阶armijo准则曲线搜索
%
%call    [X1,i] = armijo(F,x0,G,g,Rule)

%input
%   F:    Function [F] = Func(x)
%   x0    n_vector 初始点x0
%   G     n*n matrix 初始点hessen
%   g     n_vector 初始点梯度
%   Rule    Rule.rho  准则参数rho 默认0.2
%           Rule.nu   底数nu    默认0.5

%output
%   x1   n_vector  新的迭代点
%    i   scalar    函数调用次数
n = size(G);
n = n(1);
if ~isfield(Rule,'rho')
    Rule.rho = 0.2;
end
if ~isfield(Rule, 'nu')
    Rule.nu = 0.5;
end
[V,D] = eig(G);
D = diag(D);
[dt,t] = min(D);
if dt < 0;  %下降对的生成
    s = -g;
    d = V(:,t);
    
else
    s = -g;
    d = zeros(n,1);
end
u = g'*s + 1/2*d'*G*d;
u = Rule.rho*u;
i = 0;
f0 = F(x0);
while 1
    t = Rule.nu^i;
    x1 = x0 + t^2*s + t*d;
    f1 = F(x1);
    if f1 <= f0 + u*t^2
        break
    end
    i = i + 1;
end

