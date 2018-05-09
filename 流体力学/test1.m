
tau = 0.001;
h = 1;
lambda = tau/h;
gamma = 1.5;
n = 1000;
x = -1:2/n:1-1/100000;
% rho = abs(rand(1,n));
% rho = rho/mean(rho);
% u = rand(1,n);
% u = u - mean(u);
% e = abs(rand(1,n));
% % E = 10 + 0.1*randn(1,n);
% % rho = sin(x*pi)+1;
% % u = sin(x*pi)+1;
% % e = sin(x*pi)+1;
% % U = [rho;rho.*u;E];
% U = [rho;rho.*u;rho.*e+1/2*rho.*u.^2];


% % % % 
% u0 = zeros(3,n);
% for i = 1:n
%     if i < n/4 || i>n*3/4
%         u0(1,i)=0.5;
%         u0(2,i)=u0(1,i)*0.689;
%     else
%         u0(1,i)=0.45;
%         u0(2,i)=0;        
%     end
%     u0(3,i)=10+0.5*u0(2,i)^2/u0(1,i);
% end
% U = u0;

% % 
u0 = zeros(3,n);
u0(1,:) =0.2* sin(x*pi)+1;
u0(2,:) = 0.3*cos(x*pi);
u0(3,:) = 1+0.2*sin(x*pi);
U = u0;



alpha = 5;

num = 400;
f = zeros(num,alpha+1);
for i = 1:num
     U1 = FVS_1( U,gamma,lambda );
%      disp((sum(U')-sum(U1'))./(sum(U')+1))
% axis([0,130,0,10])
%     plot(x,u0(1,:),x,U1(1,:));
%     f(i,:) =falpha_weight(U1,gamma,alpha,1);

    f(i,:) =falpha_weight1(U1,gamma,alpha,1);
%     f(i,:) =falpha(U1,gamma,alpha,1);
%      f(i,:) =falpha1(U1,gamma,alpha,1);
%     plot(x,u0(1,:),x,U1(1,:));
%     plot(U1(1,:));
%     pause(0.001)
     U=U1;
end
% 
for i = 1:alpha+1
    subplot(2,3,i)
    plot(log(abs(f(:,i))));
end