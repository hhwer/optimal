function [x, out] = GRS(x,A,b,c,t)
T = 10000;
if nargin < 5
    t = 20;
end
epsilon = 1e-8;
z = x;
Q = A*A';
for i =1:T
    x = max(z,0);
    y = 2*x - z;
    lambda = Q\(-A*c+1/t*(A*y-b));
    u = y - t*(A'*lambda+c);
    z1 = z + u - x;
    disp(norm(z1-z))
    if norm(z1-z)<epsilon
        break;
    end
    z = z1;
end
out.Fun = c'*x;
out.ite = i;
end