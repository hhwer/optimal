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
cvx_begin
cvx_solver mosek;
variable x1(n);
tic;
minimize( 0.5*(A*x1-b)'*(A*x1-b) + mu*norm(x1,1) );
t1=toc;
cvx_end

% call mosek directly
% P4
clear prob;
[r, res] = mosekopt('symbcon');
prob.c = [mu*ones(2*n,1);zeros(m,1);1;0];
prob.a = sparse([A,-A,-eye(m),zeros(m,2);zeros(1,2*n+m),1,0]);
prob.blc = [b;0];
prob.buc = [b;0];
prob.blx = [zeros(2*n,1); -inf*ones(m,1);zeros(2,1)];
prob.bux = inf*ones(2*n+m+2,1);
prob.cones.type = [res.symbcon.MSK_CT_QUAD];
prob.cones.sub = [2*n+m+2,2*n+1:2*n+m];
prob.cones.subptr = [1, m+2];

prob.qcsubk = m+1;
prob.qcsubi = 2*n+m+2;
prob.qcsubj = 2*n+m+2;
prob.qcval = cell(1,1);
W = zeros(2*n+m+2, 2*n+m+2);
W(2*n+m+2,2*n+m+2) = -1;
prob.qcval{1} = W;


tic;  
[r,res]=mosekopt('minimize',prob);
t4 = toc;
x4 = res.sol.itr.xx(1:n)-res.sol.itr.xx(n+1:2*n);

fprintf('     cvx-call-mosek: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t1, errfun(x1, x1),Fun(x1));
fprintf('    cvx-call-gurobi: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t4, errfun(x1, x4),Fun(x4));