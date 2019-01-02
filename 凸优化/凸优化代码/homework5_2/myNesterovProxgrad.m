function x1 = myNesterovProxgrad(A,b,mu,x0,ep)
f = @(x)(0.5*norm(A*x-b,2)^2+mu*norm(x,1));
Q = A'*A;
bb = A'*b;
g = @(x)(Q*x-bb);
MAX = 1000;
x1 = x0;
v = x1;
t = 1/norm(Q);
for k =1:MAX
    theta = (k-2)/(k+1);
    u = x1 + theta*(x1-x0);
    u = u - t*g(u); 
    xi = t*mu;
    x1 = (u-xi).*(u>=xi)+(u+xi).*(u<=-xi);
    if norm(x0-x1)<ep && k > 1
        break;
    end
    x0 = x1;
end