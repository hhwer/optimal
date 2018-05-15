m=10000;                                 % size of matrix
n=10000;
c=500;
A = zeros(n,1);
S = zeros(n,1);
for i=1:20
    S(i)=10^(-4*(i-1)/19);
end
for i=21:n
   S(i)=(10^(-4))/(i-20)^(1/10);
end
s = spdiags(S,0,n,m);
for i=1:n
    E=zeros(m,1);
    E(i)=1;
    e=idct(E);
    f=s*e;
    A(1:m,i)=idct(f);
end


for i =1:5
    k = 10*i;
    
    tic
    [U0,sigma0,V0] = svds(A,k+1);
    t0(i)=toc;
    tic
    [U1,sigma1,V1 ] = rand_svd( A,c,k,1 );
    t1(i) = toc;

    tic
    [U2,sigma2,V2 ] = rand_svd( A,c,k,2 );
    t2(i) = toc;
%     e1(i) = norm((eye(m)-(U1*U1'))*A);
    [~,e1(i),~] = svds((eye(m)-(U1*U1'))*A,1);
%     e2(i) = norm((eye(m)-(U2*U2'))*A);
    [~,e2(i),~] = svds((eye(m)-(U2*U2'))*A,1);
    e0(i) = sigma0(k+1,k+1);
end


x = 10*(1:5);

subplot(1,2,1)
plot(x,log10((abs(e0))));
hold on
plot(x,log10((abs(e1))));
plot(x,log10((abs(e2))));
legend('svd','method1','method2')
xlabel('k')
ylabel('log10(e_{k}')
title('Îó²î')
subplot(1,2,2)
plot(x,t0,x,t1,x,t2)
legend('svd','method1','method2')
xlabel('k')
ylabel('t')
title(' ºÄÊ±')
