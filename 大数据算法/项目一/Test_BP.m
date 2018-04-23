% function Test_BP

% min ||x||_1, s.t. Ax=b

% generate data
n = 1024;
m = 512;

A = randn(m,n);
u = sprandn(n,1,0.1);
b = A*u;


x0 = rand(n,1);

errfun = @(x1, x2) norm(x1-x2)/(1+norm(x1));
resfun = @(x) norm(A*x-b);
nrm1fun = @(x) norm(x,1);

% cvx calling mosek
opts1 = []; %modify options
tic; 
[x1, out1] = l1_cvx_mosek(x0, A, b, opts1);
t1 = toc;

% cvx calling gurobi
opts2 = []; %modify options
tic; 
[x2, out2] = l1_cvx_gurobi(x0, A, b, opts2);
t2 = toc;

% % call mosek directly
opts3 = []; %modify options
tic; 
[x3, out3] = l1_mosek(x0, A, b, opts3);
t3 = toc;
% 
% call gurobi directly
opts4 = []; %modify options
tic; 
[x4, out4] = l1_mosek(x0, A, b, opts4);
t4 = toc;
% 
% % other approaches
% 
opts5 = []; %modify options
tic; 
[x5, out5] = l1_bregman(x0, A, b, opts5);
t5 = toc;

opts6 = []; %modify options
tic; 
[x6, out6] =  l1_admm(x0, A, b, opts6);
t6 = toc;


% print comparison results with cvx-call-mosek
% fprintf('cvx-mosek:        nrm1: %3.2e, res: %3.2e, cpu: %5.2f',nrm1fun(x1), resfun(x1), t1);
% fprintf('cvx-gurobi: nrm1: %3.2e, res: %3.2e, cpu: %5.2f, err-to-cvx-mosek: %3.2e\n', ...
%        nrm1fun(x2),  resfun(x2), t2, errfun(x1, x2));
% fprintf('call-mosek: nrm1: %3.2e, res: %3.2e, cpu: %5.2f, err-to-cvx-mosek: %3.2e\n', ...
%        nrm1fun(x3), resfun(x3),  t3, errfun(x1, x3));
%     fprintf('call-mosek: nrm1: %3.2e, res: %3.2e, cpu: %5.2f, err-to-cvx-mosek: %3.2e\n', ...
%         nrm1fun(x4),resfun(x3),  t4, errfun(x1, x4));
% fprintf('bregman: nrm1: %3.2e, res: %3.2e, cpu: %5.2f, err-to-cvx-mosek: %3.2e\n', ...
%         nrm1fun(x5),resfun(x5),  t5, errfun(x1, x5));
%     fprintf('admm: nrm1: %3.2e, res: %3.2e, cpu: %5.2f, err-to-cvx-mosek: %3.2e\n', ...
%         resfun(x6), nrm1fun(x6), t6, errfun(x1, x6));
fprintf('cvx-mosek &         %3.2e, res: %3.2e&%5.2f & \\\\ \n ', nrm1fun(x1),resfun(x1),t1);
fprintf('cvx-gurobi &%3.2e& %3.2e& %5.2f& %3.2e  \\\\ \n', ...
       nrm1fun(x2),  resfun(x2), t2, errfun(x1, x2));
fprintf('call-mosek & %3.2e & %3.2e& %5.2f& %3.2e \\\\ \n', ...
       nrm1fun(x3), resfun(x3),  t3, errfun(x1, x3));
    fprintf('call-mosek&  %3.2e& %3.2e&%5.2f& %3.2e \\\\ \n', ...
        nrm1fun(x4),resfun(x3),  t4, errfun(x1, x4));
fprintf('bregman& %3.2e& %3.2e& %5.2f& %3.2e \\\\ \n', ...
        nrm1fun(x5),resfun(x5),  t5, errfun(x1, x5));
    fprintf('admm&  %3.2e& %3.2e& %5.2f& %3.2e \\\\ \n', ...
       nrm1fun(x6),resfun(x6), t6, errfun(x1, x6));