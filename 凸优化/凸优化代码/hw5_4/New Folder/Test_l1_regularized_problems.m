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
cvx_begin quiet
cvx_solver mosek;
variable x1(n);
minimize( 0.5*(A*x1-b)'*(A*x1-b) + mu*norm(x1,1) );
cvx_end
t1=toc;

% AdaGrad
w = [10,1,0.1,0.01,1e-3];
ep = [1e-2,1e-3,1e-4,1e-5,1e-6];
Eta = [1,0.1,0.1,0.01,0.001];
x2 = x0;
tic
for i = 1:length(w)
    mu = w(i);
    epsilon = ep(i);
    eta = Eta(i);
    x2 = AdaGrad(x2,A,b,mu,epsilon,eta);
end
t2 = toc;

% Adam
w = [10,1,0.1,0.01,1e-3];
ep = [1e-2,1e-3,1e-4,1e-5,1e-6];
x3 = x0;
tic
for i = 1:length(w)
    mu = w(i);
    epsilon = ep(i);
    x3 = Adam(x3,A,b,mu,epsilon);
end
t3 = toc;

% RMSProp
w = [10,1,0.1,0.01,1e-3];
ep = [1e-2,1e-3,1e-4,1e-5,1e-6];
Eta = [0.001,0.0001,0.0001,0.00001,0.000001]*10;
x4 = x0;
tic
for i = 1:length(w)
    mu = w(i);
    epsilon = ep(i);
    eta = Eta(i);
    x4 = RMSProp(x4,A,b,mu,epsilon,eta);
end
t4 = toc;

% Momentum
w = [10,1,0.1,0.01,1e-3];
ep = [1e-2,1e-3,1e-4,1e-5,1e-6];
Eta = [1e-4,1e-4,1e-4,1e-5,1e-6];
Alpha = [1e-6,1e-5,1e-4,1e-3,1e-3];
x5 = x0;
tic
for i = 1:length(w)
    mu = w(i);
    epsilon = ep(i);
    eta = Eta(i);
    alpha=Alpha(i);
    x5 = Momentum(x5,A,b,mu,epsilon,eta,alpha);
end
t5 = toc;

% print comparison results with cvx-call-mosek
fprintf('     cvx-call-mosek: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t1, errfun(x1, x1),Fun(x1));
fprintf('            AdaGrad: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t2, errfun(x1, x2),Fun(x2));
fprintf('               Adam: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t3, errfun(x1, x3),Fun(x3));
fprintf('            RMSProp: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t4, errfun(x1, x4),Fun(x4));
fprintf('           Momentum: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t5, errfun(x1, x5),Fun(x5));