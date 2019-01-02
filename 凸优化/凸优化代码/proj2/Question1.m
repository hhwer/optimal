clc;clear;
errfun = @(x1, x2) (norm(x1-x2)/(1+norm(x1)));
objfun = @(x) (c'*x);
n = 100;
m = 20;
A = rand(m,n);
xs = abs(sprandn(n,1,m/n));
b = A*xs;
y = randn(m,1);
s = rand(n,1).*(xs==0);
c = A'*y+s;
opts.ep = 1e-8;
x0 = randn(n,1);
% CVX CALL MOSEK
tic;
[x1,out1]=CVXMOSEK(c, A, b, opts, x0);
t1 = toc;
% SDPNAL
tic;
[x2,out2]=ALMNCG(c, A, b, opts, x0);
t2 = toc;
% ALM with BB
tic;
[x3,out3]=ALMGrad(c, A, b, opts, x0);
t3 = toc;

fprintf('  cvx call mosek: cpu: %5.2f,  err-to-Mosek: %3.2e\n', t1, errfun(x1, x1));
fprintf(' ALMNCG for dual: cpu: %5.2f,  err-to-Mosek: %3.2e\n', t2, errfun(x1, x2));
fprintf('ALMGrad for dual: cpu: %5.2f,  err-to-Mosek: %3.2e\n', t3, errfun(x1, x3));