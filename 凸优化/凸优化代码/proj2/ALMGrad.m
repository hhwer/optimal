function [x, y] = ALMGrad (c, A, b, opts, x0)
[m,~] = size(A);
ep = opts.ep;
x = x0;
y = randn(m,1);
T = 1e3;
M = 1e3;
sigma = 2;
rho = 1;
alpham = 1e-5;
alphaM = 0.5;
for i =1:T
    alpha = 1e-2;
    g = b - A*(proj(x-sigma*(A'*y+c)));
    for j = 1:M
        y1 = y - alpha*g;
        g1 = b - A*(proj(x-sigma*(A'*y1+c)));
        Y = g1 - g;
        alpha = max(alpham,min(-alpha * (g'*g)/(g'*Y),alphaM));
        if norm(y-y1,inf)<ep
            break;
        end
        y = y1;
        g = g1;
    end
    x1 = proj(x - sigma*(A'*y+c));
    sigma = rho * sigma;
    x = x1;
end
    function w = proj (u)
        w = u.*(u>0);
    end
end