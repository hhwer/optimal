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
opts.ep = 1e-9;
x0 = randn(n,1);
% CVX CALL MOSEK
tic;
[x1,out1]=CVXMOSEK(c, A, b, opts, x0);
t1 = toc;
% ADMM for Primal
tic;
[x2,out2]=ADMM(c, A, b, opts, x0);
t2 = toc;
% DRS for dual
tic;
[x3,out3]=DRS(c, A, b, opts, x0);
t3 = toc;
% ASSN applied to DRS for Primal
tic;
[x4,out4]=ASSN(c, A, b, opts, x0);
t4 = toc;

fprintf('  cvx call mosek: cpu: %5.2f,  err-to-Mosek: %3.2e\n', t1, errfun(x1, x1));
fprintf(' ADMM for dual: cpu: %5.2f,  err-to-Mosek: %3.2e\n', t2, errfun(x1, x2));
fprintf('DRS for primal: cpu: %5.2f,  err-to-Mosek: %3.2e\n', t3, errfun(x1, x3));
fprintf('ASSN for primal: cpu: %5.2f,  err-to-Mosek: %3.2e\n', t4, errfun(x1, x4));