% function Test_l1_regularized_problems

% min 0.5 ||Ax-b||_2^2 + mu*||x||_1

% generate data
n = 1024;
m = 512;
A = randn(m,n);
u = sprandn(n,1,0.1);
b = A*u;

mu = 1e-3;

x0 = rand(n,1);

errfun = @(x1, x2) norm(x1-x2)/(1+norm(x1));


% cvx calling mosek
opts1 = []; %modify options
tic; 
[x1, out1] = l1_cvx_mosek(x0, A, b, mu, opts1);
t1 = toc;

% cvx calling gurobi
opts2 = []; %modify options
tic; 
[x2, out2] = l1_cvx_gurobi(x0, A, b, mu, opts2);
t2 = toc;

% call mosek directly
opts3 = []; %modify options
tic; 
[x3, out3] = l1_mosek(x0, A, b, mu, opts3);
t3 = toc;

% call gurobi directly
opts4 = []; %modify options
tic; 
[x4, out4] = l1_gurobi(x0, A, b, mu, opts4);
t4 = toc;

% other approaches

opts5 = []; %modify options
tic; 
[x5, out5] = l1_projection_gradient_tonglun(x0, A, b, mu, opts5);
t5 = toc;

opts6 = []; %modify options
tic; 
[x6,  out6] = l1_subgrad(x0, A, b, mu, opts6);
t6 = toc;

% print comparison results with cvx-call-mosek
fprintf('cvx-call-gurobi: cpu: %5.2f, err-to-cvx-mosek: %3.2e\n', t2, errfun(x1, x2));
fprintf('     call-mosek: cpu: %5.2f, err-to-cvx-mosek: %3.2e\n', t3, errfun(x1, x3));
fprintf('    call-gurobi: cpu: %5.2f, err-to-cvx-mosek: %3.2e\n', t4, errfun(x1, x4));
fprintf('     projection_gradient: cpu: %5.2f, err-to-cvx-mosek: %3.2e\n', t5, errfun(x1, x5));
fprintf('     subgrad: cpu: %5.2f, err-to-cvx-mosek: %3.2e\n', t6, errfun(x1, x6));