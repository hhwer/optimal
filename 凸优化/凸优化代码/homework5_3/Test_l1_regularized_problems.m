% function Test_l1_regularized_problems

% min 0.5 ||Ax-b||_2^2 + mu*||x||_1

% generate data
clear;
clc;
n = 1024;
m = 512;
A = randn(m,n);
u = sprandn(n,1,0.1);
b = A*u;
mu = 1e-3;
x0 = rand(n,1);
errfun = @(x1, x2) norm(x1-x2)/(1+norm(x1));
Fun = @(x)(0.5*(norm(A*x-b,2))^2+mu*norm(x,1));

% cvx calling mosek
tic;
cvx_begin
cvx_solver mosek;
variable x1(n);
minimize( 0.5*(A*x1-b)'*(A*x1-b) + mu*norm(x1,1) );
cvx_end
t1=toc;

% ALM for dual problem
tic;
x2 = ALM(x0,A,b,mu);
t2 = toc;

% ADMM for dual problem
tic;
x3 = ADMM(x0,A,b,mu);
t3 = toc;

% ADMM with linearization for primal problem
w = [10,1,0.1,0.01,1e-3];
ep = [1e-2,1e-3,1e-4,1e-5,1e-6];
x4 = x0;
tic
for i = 1:length(w)
    mu = w(i);
    epsilon = ep(i);
    x4 = ADMMwithline(x4,A,b,mu,epsilon);
end
t4 = toc;

% print comparison results with cvx-call-mosek
fprintf('                 cvx-call-mosek: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t1, errfun(x1, x1),Fun(x1));
fprintf('           ALM for dual problem: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t2, errfun(x1, x2),Fun(x2));
fprintf('          ADMM for dual problem: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t3, errfun(x1, x3),Fun(x3));
fprintf('  ADMM_linearization for primal: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t4, errfun(x1, x4),Fun(x4));