clear
m  = 2048;
n = 512;
% m = 10000;
% n = 10000;
p = 20;
c = 100;
A = randn(m,p)*randn(p,n);
tic
[U0,sigma0,V0] = svd(A,0);
% [U0,sigma0,V0] = svds(A,p+1);
t0 = toc;


num = 1;





for i = 1:20
    k = i;
    tic
    [U1,sigma1,V1 ] = rand_svd( A,c,k,1 );
    t1(i) = toc;

    tic
    [U2,sigma2,V2 ] = rand_svd( A,c,k,2 );
    t2(i) = toc;
    e1(i) = norm((eye(m)-(U1*U1'))*A);
    e2(i) = norm((eye(m)-(U2*U2'))*A);
    e0(i) = sigma0(k+1,k+1);
    
    sig0 = diag(sigma0);
    sig0 = sig0(1:k);
    sig1 = diag(sigma1);
    sig2 = diag(sigma2);
    err1(i) = (norm((sig0-sig1)./sig0));
    err2(i) = (norm((sig0-sig2)./sig0));
end

        plot(log10((abs(e0))));
        hold on
        plot(log10((abs(e1))));
        plot(log10((abs(e2))));
        legend('svd','method1','method2')
        xlabel('k')
        ylabel('log10(e_k)')
      

        figure(2)
        plot(err1);
        hold on
        plot(err2);
         legend('method1','method2')
         xlabel('k')
        ylabel('err')
        title([' 奇异值的比较'])
        