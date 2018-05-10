
tau = 0.01;
gamma = 1.5;
n = 50;
h = 1/n;
lambda = tau/h;
x = 0:1/n:1-1/100000;
y = x';
% rho = abs(rand(n,n));
% rho = rho/mean(mean(rho));
% u = abs(rand(n,n));
% u = u - mean(mean(u));
% v = abs(rand(n,n));
% v = v - mean(mean(v));
% e = abs(rand(n,n));
% % rho = sin(x*pi)+1;
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
num = 1000;
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
t = tau*(1:num);
for j = 1:4
    subplot(4,4,j)
    plot(t,log(abs(f(:,4,j))));
    title(['f4-',num2str(j-1)])
    subplot(4,4,j+4)
    plot(t,log(abs(f(:,j,4))));
    title(['f',num2str(j-1),'-4'])
    subplot(4,4,j+8)
    plot(t,log(abs(f(:,j,3))));
    title(['f',num2str(j-1),'-3'])
    subplot(4,4,j+12)
    plot(t,log(abs(f(:,j,2))));
    title(['f',num2str(j-1),'-2'])
end
suptitle(['2d n=',num2str(n),' tau=',num2str(tau)]);