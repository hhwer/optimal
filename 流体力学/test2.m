
tau = 0.01;
gamma = 1.5;
n = 100;
h = 1/n;
lambda = tau/h;
x = 0:1/n:1-1/100000;
y = x';
rho = abs(rand(n,n));
rho = rho/mean(mean(rho));
u = abs(rand(n,n));
u = u - mean(mean(u));
v = abs(rand(n,n));
v = v - mean(mean(v));
e = abs(rand(n,n));
% rho = sin(x*pi)+1;
% u = sin(x*pi)+1;
% e = sin(x*pi)+1;
% U = zeros(4,n,n);
% U(1,:,:) = rho;
% U(2,:,:) = rho.*u;
% U(3,:,:) = rho.*v;
% U(4,:,:) = rho.*e+1/2*rho.*(u.^2 + v.^2);
% % U0 = U;

u0 = zeros(4,n,n);
u0(1,:,:) =0.2* (sin(x*pi)+sin(y*pi))+1;
u0(2,:,:) = 0.3*(cos(x*pi)+sin(y*pi));
u0(3,:,:) = 0.2*(cos(x*pi)+sin(y*pi));
u0(4,:,:) = 1+0.2*(sin(x*pi)+sin(y*pi));
U = u0;


alpha = 3;
num = 200;
f = zeros(num,alpha+1,alpha+1);

% U = U0;
for i = 1:num
     U1 = FVS_2( U,gamma,lambda,0);
%      disp((sum(reshape(U1,4,n^2)')-sum(reshape(U,4,n^2)'))./sum(reshape(U,4,n^2)'));
%      err = norm(U1-U,'fro')/norm(U,'fro');
%      disp(err);
%      if err < 1e-6
%          break
%      end
     f(i,:,:) =falpha_weight1(U1,gamma,alpha,2);
     U=U1;
end

for i = 1:4
    subplot(4,4,i)
    plot(log(abs(f(:,4,i))));
    subplot(4,4,i+4)
    plot(log(abs(f(:,i,4))));
    subplot(4,4,i+8)
    plot(log(abs(f(:,i,3))));
    subplot(4,4,i+12)
    plot(log(abs(f(:,i,2))));
end