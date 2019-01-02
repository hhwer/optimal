function [Jk] = J(D,y)
    y(y>0) = 1;
    y(y<0) = 0;
    M = diag(y);
    Jk = M+D*(eye(size(y,1))-2*M);
end