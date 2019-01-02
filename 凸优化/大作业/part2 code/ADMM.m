function [y, out] = ADMM(y,s,A,b,c,beta)
T = 10000;
if nargin < 6
    beta = 200;
end
epsilon = 1e-9;
x = c;
Q = A*A';


for i =1:T
    y1 = Q\(b/beta+A*(c+x-s));
    aa = A'*y1-c;  %%ÖÐ¼äÁ¿
    s = x-aa;
    s(s<0) = 0;
    x = x - (s+aa);
    disp(norm(y1-y))
    if norm(y1-y)<epsilon
        break;
    end
    y = y1;
end
out.Fun = -b'*y;
out.s = s;
out.x = x/beta;
out.ite = i;
end