% min c'*x 
% subject to Ax = b, x >= 0

% generate data
n = 100;
m = 20;
A = rand(m,n);
xs = full(abs(sprandn(n,1,m/n))); b = A*xs;
y = randn(m,1);
s = rand(n,1).*(xs==0);
c = A'*y+s;

objfun = @(x) c'*x;
c1 = @(x) norm(A*x-b);
c2 = @(x) norm(x .* (x<0))
errfun = @(x1, x2) norm(x1-x2)/(1+norm(x1));


x0 = randn(n,1);

% cvx call mosek
opts1 = []; %modify options
tic; 
[x1, out1] = lp_cvx_mosek(c, A, b, opts1, x0);
t1 = toc;

% ALM for dual
opts2 = []; %modify options
tic; 
[x2, out2] = lp_alm(c, A, b, opts2, x0);
t2 = toc;

% DRS for primal
opts3 = []; %modify options
tic; 
[x3, out3] = lp_drs(c, A, b, opts3, x0);
t3 = toc;

% ADMM for dual
opts4 = []; %modify options
tic; 
[x4, out4] = lp_admm(c, A, b, opts4, x0);
t4 = toc;

% % Semi-Smooth Newton Method for primal
% opts5 = []; %modify options
% tic; 
% [x5, out5] = lp_ssnm(c, A, b, opts5, x0);
% t5 = toc;

% Compare the result with Mosek Linear Solver
fprintf(' cvx call mosek: cpu: %5.2f, obj: %3.2e, c_eq: %3.2e, c_ineq: %3.2e, err-to-Mosek: %3.2e\n', t1, objfun(x1), c1(x1), c2(x1), errfun(x1, x1));
fprintf('   ALM for dual: cpu: %5.2f, obj: %3.2e, c_eq: %3.2e, c_ineq: %3.2e, err-to-Mosek: %3.2e\n', t2, objfun(x2), c1(x2), c2(x2), errfun(x1, x2));
fprintf(' DRS for primal: cpu: %5.2f, obj: %3.2e, c_eq: %3.2e, c_ineq: %3.2e, err-to-Mosek: %3.2e\n', t3, objfun(x3), c1(x3), c2(x3), errfun(x1, x3));
fprintf('  ADMM for dual: cpu: %5.2f, obj: %3.2e, c_eq: %3.2e, c_ineq: %3.2e, err-to-Mosek: %3.2e\n', t4, objfun(x4), c1(x4), c2(x4), errfun(x1, x4));
% fprintf('SSNM for primal: cpu: %5.2f, obj: %3.2e, c_eq: %3.2e, c_ineq: %3.2e, err-to-Mosek: %3.2e\n', t5, objfun(x5), c1(x5), c2(x5), errfun(x1, x5));