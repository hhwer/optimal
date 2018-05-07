m  = 2048;
n = 512;
% m = 200;
% n = 100;
p = 20;
c = 200;
k = 20;
A = randn(m,p)*randn(p,n);
tic
[U0,sigma0,V0] = svd(A,0);
t0 = toc;




sigma0 = diag(sigma0);
sigma0 = sigma0(1:k);

tic
[U1,sigma1,V1,t_q1 ] = rand_svd( A,c,k,1 );
t1 = toc;

tic
[U2,sigma2,V2,t_q2 ] = rand_svd( A,c,k,2 );
t2 = toc;

sigma1 = diag(sigma1);
sigma2 = diag(sigma2);
% sig = [sigma0(1:k),sigma(1:k)];
% err = (sig(:,1)-sig(:,2))./sig(:,1);
% disp(err(1));