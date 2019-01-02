clc;
clear;

n = 1024;
m = 512;

A = randn(m,n);
u = sprandn(n,1,0.1);
b = A*u;

errfun = @(x1, x2) norm(x1-x2)/(1+norm(x1));
mu = 1e-3;

f = @(x)(0.5*(norm(A*x-b,2))^2+mu*norm(x,1)); 
cvx_begin
cvx_solver mosek;
cvx_save_prefs;
variable x1(n);
tic;
minimize( 0.5*(A*x1-b)'*(A*x1-b) + mu*norm(x1,1) );
t1=toc;
cvx_end


x0 = rand(n,1);
tic
x5 = subgrad(A,b,mu,x0);
t5 = toc;
fprintf('     methodxxxx: cpu: %5.2f, err-to-cvx-mosek: %3.2e\n', t5, errfun(x1, x5));
fprintf('     methodxxxx: cpu: %5.2f, err-to-cvx-mosek: %3.2e\n', t5, errfun(x0, x5));
fprintf('f1: %5.2f, f2: %5.2f\n', f(x1),f(x5));

% disp(f(x0));
% disp(0.5*[x0;zeros(n,1)]'*Q*[x0;zeros(n,1)]+c'*[x0;zeros(n,1)]+0.5*(b'*b));