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
% cvx_solver mosek;
variable x1(n);
tic;
minimize( 0.5*(A*x1-b)'*(A*x1-b) + mu*norm(x1,1) );
t1=toc;
cvx_end
tic;
x2=admm_linprim(x0, A, b, mu);
t2 = toc;
fprintf('    Proxgrad for primal: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t2, errfun(x1, x2),Fun(x2));