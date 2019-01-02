function [x,out] = ASSN (c, A, b, opts, x0)
[~,n] = size(A);
out = [];
z = randn(n,1);
x = x0;
ep = opts.ep;
T = 5000;
t = 100;
nu = 0.5;
eta1 = 0.1;
eta2 = 0.5;
gamma1 = 2;
gamma2 = 10;
W = A'*((A*A')\A);
w = A'*((A*A')\b);
QQ = eye(n)-2*W;
Q = eye(n)-W;
What = (QQ)\(Q);
FU = norm(F(z));
lambda = 1;
lambdabar = 0.1;
for i =1:T
    dproxh = eye(n);
    dproxh((x==0),:)=0;
    J = dproxh-What*(2*dproxh-eye(n));
    Fz = F(z);
    mu = lambda*norm(Fz);
    d = (J+mu*eye(n))\(-Fz);
    u = z+d;
    Fu = F(u);
    rho = -(Fu'*d)/(d'*d);
    if rho > eta1
       if norm(Fu)<=nu * FU
           z1 = u;
           FU = norm(Fu);
       else
           z1 = z - (Fu'*(z-u))/(Fu'*Fu)*Fu;
       end
    end
    if rho >= eta2
        lambda = 0.5*(lambdabar+lambda);
    elseif rho >= eta1
        lambda = 0.5*(gamma1+1)*lambda;
    else
        lambda = 0.5*(gamma1+gamma2)*lambda;
    end
    x = proj(z1);
    if norm(z1-z,inf)<ep  && norm(Fz,inf)<ep*100
        break;
    end
    z = z1;
%     x = x1;   
end
disp(i);
    function w = proj (u)
        w = u.*(u>0);
    end
    function y = proxg(x,t)
        g = (Q)*(x-t*c);
        y = (QQ)\(g-w);
    end
    function y = F(x)
        y = proj(x)-proxg(2*proj(x)-x,t);
    end
end