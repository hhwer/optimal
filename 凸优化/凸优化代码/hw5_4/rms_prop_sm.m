function [x,out] = rms_prop_sm(x0,A,b,mu,x1)
Q = A'*A;
bb = A'*b;
errfun = @(x1, x2) norm(x1-x2)/(1+norm(x1));
tic;
mulist = [100,10,1,0.1,0.01,0.001];
eplist = [1e-1,1e-2,1e-2,1e-3,1e-5,1e-6];
pmulist = [1e-1,1e-2,1e-2,1e-2,1e-3,1e-4,1e-4];
etalist = [1,1e-1,1e-1,2e-2,3e-2,1e-2,1e-3];
maxlist = [1000,1000,2000,3000,3000,10000,10000];
stlist = [];  
xk_1 = x0;
for j = 1:length(mulist)
    [xk,st,r] = rms_prop_sm_sub(xk_1,Q,bb,A,b,mulist(j),pmulist(j),maxlist(j),eplist(j),etalist(j));
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


function [x,st,r] = rms_prop_sm_sub(x0,Q,bb, A, b, mu, pmu,mx,epsilon,eta)
n = size(x0,1);
delta = 3e-1;
rho = 0.4;
k = 1;
r = x0*0;
x=x0;
g = Q*x-bb+mu*sign(x);
while norm(g,inf) >= epsilon && k <= mx
%     g_1 = g;
    g = Q*x-bb+mu*grad_phi(x,pmu);
    r = rho*r+(1-rho)*g.*g;
    t = eta./(delta+r).^0.5.*g;
    x = x-t;
    k = k+1;
end

st = k;

function x = grad_phi(x,mu)
   for i =1:n
       if abs(x(i))>mu
           x(i) = sign(x(i));
       else
           x(i) = x(i)/mu;
       end
   end
end

end
   