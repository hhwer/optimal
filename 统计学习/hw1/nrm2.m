function [y] = nrm2(X)
p = 2;
y = sum(abs(X).^p,1).^(1/p);
end