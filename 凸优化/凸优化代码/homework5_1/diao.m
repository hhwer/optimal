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
cvx_begin
cvx_solver mosek;
variable x1(n);
tic;
minimize( 0.5*(A*x1-b)'*(A*x1-b) + mu*norm(x1,1) );
t1=toc;
cvx_end

% cvx calling gurobi
cvx_begin
cvx_solver gurobi;
variable x2(n);
tic;
minimize( 0.5*norm(A*x2-b,2)+mu*norm(x2,1) );
t2 = toc;
cvx_end

% call mosek directly
% P2
q = [A'*A,-A'*A;-A'*A,A'*A];
c = [-A'*b+mu*ones(n,1);A'*b+mu*ones(n,1)];
a = eye(2*n);
blc = -inf*ones(2*n,1);
buc = inf*ones(2*n,1);
blx = zeros(2*n,1);
bux = inf*ones(2*n,1);
tic;  
X31 = mskqpopt(q, c, a, blc, buc, blx, bux);
t31 = toc;
x31 = X31.sol.itr.xx(1:n)-X31.sol.itr.xx(n+1:2*n);
% P3
q = [A'*A,zeros(n);zeros(n),zeros(n)];
c = [-A'*b;mu*ones(n,1)];
a = [eye(n),-eye(n);eye(n),eye(n)];
blc = [-inf*ones(n,1);zeros(n,1)];
buc = [zeros(n,1);inf*ones(n,1)];
blx = [-inf*ones(n,1);zeros(n,1)];
bux = inf*ones(2*n,1);
tic;  
X32 = mskqpopt(q, c, a, blc, buc, blx, bux);
t32 = toc;
x32 = X32.sol.itr.xx(1:n);

% call gurobi directly
% P2
model.Q = sparse(0.5*[A'*A,-A'*A;-A'*A,A'*A]);
model.A = sparse(eye(2*n));
model.obj = [-A'*b+mu*ones(n,1);A'*b+mu*ones(n,1)];
model.rhs = zeros(2*n,1);
model.sense = repmat('>',2*n,1);
model.lb =zeros(2*n,1);
model.vtype = 'C';
modle.modelsense='min';
clear params;
params.outputflag = 0;   
tic;
result = gurobi(model, params);
t41 = toc;
x41 = result.x(1:n)-result.x(n+1:2*n);
% P3
clear model;
model.Q = sparse([0.5*(A'*A),zeros(n);zeros(n),zeros(n)]);
model.A = sparse([eye(n),-eye(n);eye(n),eye(n)]);
model.obj = [-A'*b;mu*ones(n,1)];
model.rhs = zeros(2*n,1);
model.sense = [repmat('<',n,1);repmat('>',n,1)];
model.lb =[-inf*ones(n,1);zeros(n,1)];
model.vtype = 'C';
modle.modelsense='min';
clear params;
params.outputflag = 0;   
tic;
result = gurobi(model, params);
t42 = toc;
x42 = result.x(1:n);

% Projection gradient

Q = [A'*A,-A'*A;-A'*A,A'*A];
c = [-A'*b+mu*ones(n,1);A'*b+mu*ones(n,1)];
tic
X = BMR(Q,c,x0);
t5 = toc;
x5 = X(1:n)-X(n+1:2*n);

% subgradient

tic
x6 = subgrad(A,b,mu,x0);
t6 = toc;

% print comparison results with cvx-call-mosek
fprintf('     cvx-call-mosek: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t1, errfun(x1, x1),Fun(x1));
fprintf('    cvx-call-gurobi: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t2, errfun(x1, x2),Fun(x2));
fprintf('     call-mosek  P2: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t31, errfun(x1, x31),Fun(x31));
fprintf('     call-mosek  P3: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t32, errfun(x1, x32),Fun(x32));
fprintf('    call-gurobi  P2: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t41, errfun(x1, x41),Fun(x41));
fprintf('    call-gurobi  P3: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t42, errfun(x1, x42),Fun(x42));
fprintf('Projection gradient: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t5, errfun(x1, x5),Fun(x5));
fprintf('        subgradient: cpu: %5.2f, err-to-cvx-mosek: %3.2e, Optimal objective:%3.2e\n', t6, errfun(x1, x6),Fun(x6));