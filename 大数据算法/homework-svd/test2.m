clear
m  = 2048;
n = 512;
p = 20;
A = randn(m,p)*randn(p,n);
tic
[U0,sigma0,V0] = svd(A,0);
% [U0,sigma0,V0] = svds(A,p+1);
t0 = toc;


k=20;





for i = 1:40
    c = 10*(i+1);
    tic
    [U1,sigma1,V1 ] = rand_svd( A,c,k,1 );
    t1(i) = toc;

    tic
    [U2,sigma2,V2 ] = rand_svd( A,c,k,2 );
    t2(i) = toc;
    e1(i) = norm((eye(m)-(U1*U1'))*A);
    e2(i) = norm((eye(m)-(U2*U2'))*A);
    e0(i) = sigma0(k+1,k+1);
    
end
        x = 10*(2:41);
        
        subplot(1,2,1)
        plot(x,log10((abs(e0))));
        hold on
        plot(x,log10((abs(e1))));
        plot(x,log10((abs(e2))));
        legend('svd','method1','method2')
        xlabel('c')
        ylabel('log10(e_{10}(k))')
        title('Îó²î')
 subplot(1,2,2)       
% t0 = ones(40,1)*t0;
plot(x,t0,x,t1,x,t2)
legend('svd','method1','method2')
xlabel('c')
ylabel('t')
title(' ºÄÊ±')
suptitle(['k=',num2str(k)])
        