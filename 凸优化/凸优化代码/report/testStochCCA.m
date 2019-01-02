% clear;
clc;
n = 50;
d1 = 15;
d2 = 10;
sparsity = 0.15;
k = 1;
x = randn(n,d1);
y = randn(n,d2);

x = x-repmat(mean(x,1), n, 1);
y = y-repmat(mean(y,1), n, 1);


[Vx, Vy] = canoncorr(x, y);
Vx = Vx(:, 1:k);
Vy = Vy(:, 1:k);

lambda = 0;
sxx = x'*x/(n-1)+ lambda*eye(d1);
syy = y'*y/(n-1)+ lambda*eye(d2);
sxy = x'*y/(n-1);
% M = sxx^(-0.5) * sxy * syy^(-0.5); % d1*d2
% [Wx, ~, Wy] = svd(M);
% Wx = sxx^-0.5*Wx;
% Wy = syy^-0.5*Wy;
% Wx = Wx(:, 1:k);
% Wy = Wy(:, 1:k);
T = 1000;
[Wx,Wy] = Stoch_CCA(x, y, T, k);
cos_x = calc_cos(Wx, Vx, sxx);
cos_y = calc_cos(Wy, Vy, syy);
% tcc = TCC(x*Wx, y*Wy);
% pcc = PCC(x, y, Wx, Wy, Vx, Vy);
fprintf('cos_x=%.3f, cos_y=%.3f\n', ...
        cos_x, cos_y);