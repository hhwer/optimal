Rule.opt = 2;
Rule.nu = 0.8;
Rule.rho = 0.1;
Rule.beta = 0.5;
mu = 100;


p = 10;
Rule.c = 10;
Rule.epi = 0;


Funcs = @Funcs_filter;
x0 = [0,1,0,-0.15,0,-0.68,0,-0.72,0.37]';
% x0(2) = x0(2)-1e-8;
m = 82;

% Funcs = @Funcs3;
% x0 = zeros(4,1);
% % % exact_x = [0,1,2,-1]';
% m =4;


% Funcs = @Funcs2;
% x0 = [1,-0.1]';
% m = 3;
%

% % %smooth method
% [x1,f1,trace]=smooth( Funcs,m,x0,mu,Rule );
%


% % % p-th method
[x1,f1,trace]= pth( Funcs,m,x0,p,Rule );
% 


% % % method 3
% p = 10
% Rule.sigma = 0.01;
% Rule.theta =0.9;
% [ x1,f1,trace ] =; smooth2( Funcs,m,x0,p,Rule );