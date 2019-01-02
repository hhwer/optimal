
n = 100;
m = 20;
A = randn(m,n);
xs = full(abs(sprandn(n,1,m/n)));
b = A*xs;
y = randn(m,1);
s = rand(n,1).*(xs==0);
c = A'*y + s;
Fun = @(x)c'*x;

tic; 
cvx_begin
    cvx_solver mosek
    variable x1(n)
    minimize( c'*x1  )
    subject to
        A * x1 == b
        x1 >= 0
cvx_end
t1 = toc;

tic; 
cvx_begin
    cvx_solver mosek
    variable y1(m) 
    variable s1(n)
    minimize( -b'*y1  )
    subject to
        A' * y1 + s1 == c 
        s1 >= 0
cvx_end
t2 = toc;

x = rand(n,1);
tic
[x2,out2] = GRS(x,A,b,c);
t3 = toc;

y = rand(m,1);
tic
[y2,out3] = ADMM(y,s,A,b,c);
t4 = toc;

Rule.nu = 0.99;
Rule.eta1 = 0.0001;
Rule.eta2 = 0.5;
Rule.gamma1 = 2;
Rule.gamma2 = 10;
Rule.lambda = 1e-4;
Rule.epi = 1e-6;


x = rand(n,1);

tic
[x3,out4] =semiSmoothNewton(x,A,b,c,Rule);
t5 = toc;

f1 = x1'*c;
f2 = -y1'*b;
err1 = (x2'*c-f1)/f1;
err2 = (-y2'*b-f2)/f2;
err3 = (x3'*c-f1)/f1;
etap0 = norm(A*x1-b)/(1+norm(b));
etad0 = norm(A'*y1+s1-c)/(1+norm(c));
etap1 = norm(A*x2-b)/(1+norm(b));
etad2 = norm(A'*y2+out3.s-c)/(1+norm(c));
etap3 = norm(A*x3-b)/(1+norm(b));
fprintf(['%4.2f & %2.1e '...
            '& %4.2f & %2.1e & %2.1e & %d' ...
            '& %4.2f & %2.1e & %2.1e & %d\n'],...
            t1,etap0,t3,etap1,err1,out2.ite,t5,etap3,err3,out4.ite); 
 fprintf([' %4.2f & %2.1e '...
            '& %4.2f & %2.1e & %2.1e & %d\n'],...
            t2,etad0,t4,etad2,err2,out3.ite);     
        