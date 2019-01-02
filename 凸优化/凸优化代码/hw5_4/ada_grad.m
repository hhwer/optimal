function [x,out] = ada_grad(x0,A,b,mu,x1)
maxsub = 10000;
Q = A'*A;
bb = A'*b;
r = x0*0;
errfun = @(x1, x2) norm(x1-x2)/(1+norm(x1));
tic;
mulist = [100,10,1,0.1,0.01,0.001];
eplist = [1e-1,1e-2,1e-3,1e-4,1e-5,1e-6];
stlist = [];  
xk_1 = x0;
for j = 1:length(mulist)
    [xk,st] = ada_grad_sub(xk_1,Q,bb,A,b,mulist(j),maxsub,eplist(j));
    stlist(j) = st;
    xk_1 = xk;
end
x = xk;
out.st = stlist;
out.fv = 0.5*norm(A*x-b, 2)^2 + mu * norm(x, 1);
t1 = toc;
out.r = r;
fprintf('ada_grad : cpu: %5.2f, err-to-cvx-mosek: %3.2e\n', t1, errfun(x, x1));
end


function [x,st] = ada_grad_sub(x0,Q,bb,A,b,mu,mx,epsilon)
delta = 1e-5;
k = 1;
eta = 0.2;
r = x0*0;
x=x0;
g = Q*x-bb+mu*sign(x);
while norm(g,inf) >= epsilon && k <= mx
%     g_1 = g;
    g = Q*x-bb+mu*sign(x);
    r = r+g.*g;
    t = eta./(delta+(r).^0.5).*g;
    x = x-t;
    k = k+1;
end
st = k;
end
   