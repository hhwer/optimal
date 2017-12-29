function [U] = finiteElemet(N)
%triangular finite element method 
%input   
%       N     int               question scale
%
%output     
%       U     vector         pointvalue

lambda = 3.65*1e4;
mu = 1.5250*1e4;
f = 10;
[en,Ke] = order(N,lambda,mu);
[K,F] = getGlobalK(Ke,en,f,N);

U = K\F;

U1 = reshape(U(1:(N+1)^2),N+1,N+1)';
U2 = reshape(U((N+1)^2+1:2*(N+1)^2),N+1,N+1)';
[rho1,rho2,rho12,rho3] = stress(U1,U2,lambda,mu);
myplot(U1,U2,rho1,rho2,rho12,rho3);

end