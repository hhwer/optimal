% clear;
% clc;
n = 1024;
m = 512;
A = randn(m,n);
u = sprandn(n,1,0.1);
b = A*u;
mu = 1e-3;
x0 = rand(n,1);
errfun = @(x1, x2) norm(x1-x2)/(1+norm(x1));
Fun = @(x)(0.5*(norm(A*x-b,2))^2+mu*norm(x,1));
cvx_begin
cvx_solver mosek;
variable x1(n);
tic;
minimize( 0.5*(A*x1-b)'*(A*x1-b) + mu*norm(x1,1) );
t1=toc;
cvx_end
w = [10,1,0.1,0.01,1e-3];
ep = [1e-2,1e-3,1e-4,1e-5,1e-6];
% w = 1e-3;
% ep = 1e-6;
tic
for i = 1:length(w)
    mu = w(i);
    epsilon = ep(i);
    x0 = Adam(x0,A,b,mu,epsilon);
end
t2 = toc;
x2 = x0;
fprintf('    Proxgrad for primal: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t2, errfun(x1, x2),Fun(x2));