clear;
n = 10;
d1 = 7;
d2 = 3;
X = rand(n,d1);
Y = rand(n,d2);
Xx = X-repmat(mean(X,1), n, 1);
Yy = Y-repmat(mean(Y,1), n, 1);
SXX = Xx'*Xx/(n-1);  %d1*d1
SYY = Yy'*Yy/(n-1);  %d2*d2
SXY = Xx'*Yy/(n-1);  %d1*d2
[Vx, Vy, R, Ux, Uy] = canoncorr(Xx, Yy);
% Vx = Vx-repmat(mean(Vx), d1, 1);
Vx'*SXX*Vx
Vy'*SYY*Vy
Vx'*SXY*Vy
R
% R
% Ux'*Ux
% Uy'*Uy