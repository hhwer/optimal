
tau = 0.1;
h = 1;
lambda = tau/h;
gamma = 1.5;
n = 100;
x = 0:1/100:1-1/1000;
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
U = zeros(4,n,n);
U(1,:,:) = rho;
U(2,:,:) = rho.*u;
U(3,:,:) = rho.*v;
U(4,:,:) = rho.*e+1/2*rho.*(u.^2 + v.^2);


for i = 1:10
     U1 = FVS_2( U,gamma,lambda,0);
     disp((sum(reshape(U1,4,n^2)')-sum(reshape(U,4,n^2)'))./sum(reshape(U,4,n^2)'));
%      err = norm(U1-U,'fro')/norm(U,'fro');
%      disp(err);
%      if err < 1e-6
%          break
%      end
     U=U1;
end