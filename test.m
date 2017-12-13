Rule.opt = 2;
Rule.nu = 0.8;
Rule.rho = 0.1;
Rule.beta = 0.5;
mu = 100;


p = 10;
Rule.c = 1;
Rule.epi = 1;


Funcs = @Funcs3;
x0 = zeros(4,1);
% % exact_x = [0,1,2,-1]';
m =4;

% Funcs = @Funcs2;
% x0 = [1,-0.1]';
% m = 3;

% [x1,f1]=smooth( Funcs,m,x0,mu,Rule );
[x1,f1]= pth( Funcs,m,x0,p,Rule );
