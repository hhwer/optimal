% p = 5000;
% n = 100;
% mu = 1e-3;
% X = randn(n,p);
% weights = sprandn(p,1,0.1);
% y = X*weights + 2; 
lambda_num = 100;
lambda_max = 1e0;
lambda_min = 1e-4;
lambda = exp([log(lambda_min):(log(lambda_max)- ...
    log(lambda_min))/lambda_num:log(lambda_max)]);

Beta_cvx = zeros(p, lambda_num);
Beta_0 = zeros(p, lambda_num);
err = zeros(lambda_num,1);
for i = 1:lambda_num
mu = lambda(i);
cvx_begin
variable x1(p);
variable b0(1)
tic;
minimize( 0.5*(X*x1-y+b0)'*(X*x1-y+b0) + mu*norm(x1,1) );
t1=toc;
cvx_end
a_p = cvx_optval;

% one = ones(n,1);
% cvx_begin
% variable x1(p);
% variable Y(n);
% variable b0(1)
% tic;
% minimize( 0.5*(Y)'*(Y) + mu*norm(x1,1) );
% subject to
%     Y == X*x1-y+b0*one
% t1=toc;
% cvx_end
% a_d = cvx_optval;


x0 = zeros(p,1);
% w = [10,1,0.1,0.01,1e-3];
% ep = [2e-4,2e-6,2e-6,1e-6,1e-6];
ep = 1e-6;
tic
[x2,out] = ADMM_intercept(x0,X,y,mu,ep);
t2 = toc;
% b0 = mean(y) - x_mean*x0;
% norm(X*x0+b0-y,inf)
beta0 = out.intercept;
err(i) = (0.5*norm(X*x2+beta0-y)^2+mu*norm(x2,1)-a_p)/a_p;
% 0.5*norm(-X*x0+beta0-y)^2+mu*norm(x0,1)
Beta_cvx(: ,i) = x1;
Beta_0(:, i) = x2;
end
for i = 1:5000
plot(log(lambda(1:end-1)),Beta_0(i,:))
hold on
end