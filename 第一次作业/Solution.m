function[x1,f1,k,t,ite] = Solution(situation,n,status,Rule)
if situation == 0    %ExRosenbrockº¯Êý  nÊÇÅ¼Êý
    if mod(n,2)
        n = n+1;
    end
    func = @ExRosenbrock;
    Objfun = @extend_rosen;
    x0 = ones(n,1);
    for i = 1:n/2
        x0(2*i-1) = -1.2;
    end
elseif situation == 1
    func = @Trigonometric;
    Objfun = @ObjFunc_Trigonometric;
    x0 = ones(n,1);
    x0 = x0/n;
elseif situation == 2
    func = @DisboundvalJ;
    Objfun = @dis_boundval;
    x0 = zeros(n,1);
    h = 1/(1+n);
    for i = 1:n
        x0(i) = i*h*(i*h-1);
    end
elseif situation == 3
    func = @func_wood;
    Objfun = @wood;
    x0 = [-3,-1,-3,-1]';
end
epi = 1e-8;
if nargin < 3
    opt = 1;
end
[x1,f1,k,t,ite,f] = Newton( func, Objfun, x0, epi,status,Rule);