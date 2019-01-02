function x = NesterovProxgrad(A,b,mu,x0,ep)
f = @(x)(0.5*norm(A*x-b,2)^2+mu*norm(x,1));
Q = A'*A;
bb = A'*b;
g = @(x)((Q*x-bb)/mu);
MAX = 1000;
x1 = x0;
v = x1;
t = 1/norm(Q)*mu;
t = 1/t;
F(1) =f(x1); 
for k =1:MAX
    x = x1;
    theta = 2/(k+1);
    xi = t/theta;
    y = (1-theta)*x + theta*v;
    u = v - xi*g(y); 
    v = (u-xi).*(u>=xi)+(u+xi).*(u<=-xi);
    x1 = (1-theta)*x + theta*v;
    F(k+1) = f(x1);
    if norm(x-x1)<ep && k > 1
        break;
    end
end
