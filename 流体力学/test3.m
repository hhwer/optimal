
tau = 0.01;
gamma = 1.5;
n = 10;
h = 1/n;
lambda = tau/h;
x = 0:1/n:1-1/1000;
y = x';
% rho = abs(rand(n,n,n));
% rho = rho/mean(mean(mean(rho)));
% u = abs(rand(n,n,n));
% u = u - mean(mean(mean(u)));
% v = abs(rand(n,n,n));
% v = v - mean(mean(mean(v)));
% w = abs(rand(n,n,n));
% w = w - mean(mean(mean(w)));
% e = abs(rand(n,n,n));
% E = abs(rand(n,n,n));
% rho = sin(x*pi)+1;
% % u = sin(x*pi)+1;
% % e = sin(x*pi)+1;
% U = zeros(5,n,n,n);
% U(1,:,:,:) = rho;
% U(2,:,:,:) = rho.*u;
% U(3,:,:,:) = rho.*v;
% U(4,:,:,:) = rho.*w;
% U(5,:,:,:) = rho.*e+1/2*rho.*(u.^2 + v.^2+w.^2);

u0 = zeros(4,n,n,n);
for i = 1:n
u0(1,i,:,:) =reshape(0.2* (sin(x*pi)+sin(y*pi)),1,1,n,n)+1;
u0(2,i,:,:) = reshape(0.3*(cos(x*pi)+cos(y*pi)),1,1,n,n);
u0(3,i,:,:) = reshape(0.2*(cos(x*pi)+cos(y*pi)),1,1,n,n);
u0(4,i,:,:) = reshape(0.1*(cos(x*pi)+cos(y*pi)),1,1,n,n);
u0(5,i,:,:) = reshape(10+0.2*(sin(x*pi)+sin(y*pi)),1,1,n,n);
end
U = u0;


alpha = 3;
num = 1000;
f = zeros(num,alpha+1,alpha+1,alpha+1);


for i = 1:num
     U1 = FVS_3( U,gamma,lambda,0);
%      disp((sum(reshape(U1,5,n^3)')-sum(reshape(U,5,n^3)'))./sum(reshape(U,5,n^3)'));
     f(i,:,:,:) =falpha_weight1(U1,gamma,alpha,3);
     U=U1;
end

t = tau*(1:num);
for j = 1:4
    subplot(3,4,j)
    plot(t,log(abs(f(:,1,1,j))));
    set(gca,'FontName','Times New Roman','FontSize',8)
    title(['f0-0-',num2str(j-1)])
    subplot(3,4,j+4)
    plot(t,log(abs(f(:,1,2,j))));
     set(gca,'FontName','Times New Roman','FontSize',8)
    title(['f0-1-',num2str(j-1)])
    subplot(3,4,j+8)
    plot(t,log(abs(f(:,1,3,j))));
    set(gca,'FontName','Times New Roman','FontSize',8)
    title(['f0-2-',num2str(j-1)])
end
suptitle(['3d n=',num2str(n),' tau=',num2str(tau)]);