function  u = SVRG1(v0,X,Y,eta,M,m,epsilon)
s = 5;
[dx,N] = size(X);
g = @(v)(X*(X'*v-Y'*v0)/N+eta*v);
u = zeros(dx,1);
u1 = u;
w = cell(m+1,1);
for j =1:M
    w0 = u;
    g0 = g(w0);
    w{1} = w0;
    for t = 1:m
        i  = randi(N);
        w{t+1} = w{t} - s*((X(:,i)'*X(:,i)+eta*eye(dx))*(w{t}-w0))+g0;
    end
    t = randi(m);
    u = w{t};
    if norm(u-u1)<epsilon
        break;
    end
    u1 = u;
end 