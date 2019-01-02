k = 100;
n = 1000;
B0 = randn(n);
B = B0'*B0;
W = normrnd(0,1,n,k);
W =  GSB111(W,B);
P = norm(W'*B*W-eye(k));