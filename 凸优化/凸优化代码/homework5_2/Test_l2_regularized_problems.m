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
opts1 = []; %modify options
tic; 
[x1, out1] = l1_cvx_mosek(x0, A, b, mu, opts1);
t1 = toc;

% BB for smoothed primal problem
w = [10,1,0.1,0.01,1e-3];
ep = [1e-1,1e-2,1e-2,1e-5,1e-6];
lambda = [1e-1,1e-2,1e-3,1e-5,1e-6];
x2 = x0;
tic
for i = 1:length(w)
    mu = w(i);
    epsilon = ep(i);
    lamb = lambda(i);
    x2 = myBBforsmooth(A,b,mu,x2,3,lamb,epsilon);
end
t2 = toc;

% Nesterov for smoothed primal problem
w = [1,0.01,1e-3];
ep = [1e-2,1e-4,1e-6];
lambda = [1e-2,1e-4,1e-6];
x3 = x0;
tic
for i = 1:length(w)
    mu = w(i);
    epsilon = ep(i);
    lamb = lambda(i);
    x3 = myNesterovForSmoothed(A,b,mu,x3,3,lamb,epsilon);
end
t3 = toc;

% proximal gradient for primal
w = [10,1,0.1,0.01,1e-3];
ep = [2e-4,1e-5,2e-6,1e-6,1e-6];
x4 = x0;
tic
for i = 1:length(w)
    mu = w(i);
    epsilon = ep(i);
    x4 = myProxgrad(A,b,mu,x4,epsilon);
end
t4 = toc;


% Nesterov'smethod for primal
w = [10,1,0.1,0.01,1e-3];
ep = [1e-4,1e-5,2e-6,1e-6,1e-6];
x5 = x0;
tic
for i = 1:length(w)
    mu = w(i);
    epsilon = ep(i);
    x5 = myNesterovProxgrad(A,b,mu,x5,epsilon);
end
t5 = toc;

% print comparison results with cvx-call-mosek
fprintf('                    cvx-call-mosek: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t1, errfun(x1, x1),Fun(x1));
fprintf('           BB for smoothed problem: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t2, errfun(x1, x2),Fun(x2));
fprintf('     Nesterov for smoothed problem: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t3, errfun(x1, x3),Fun(x3));
fprintf('      proximal gradient for primal: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t4, errfun(x1, x4),Fun(x4));
fprintf('Nesterovs second method for primal: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t5, errfun(x1, x5),Fun(x5));