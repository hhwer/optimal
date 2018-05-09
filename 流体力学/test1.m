
tau = 0.001;
% tau = 1e-6;
gamma = 1.5;
n = 100;
h = 2/n;
lambda = tau/h;
x = -1:2/n:1;
x = x(1:n);
% n = n+1;

% % % % % 
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


u0 = zeros(3,n);
u0(1,:) =0.2* cos(x*pi)+1;
u0(2,:) = 0.3*sin(x*pi);
u0(3,:) = 10+0.2*cos(x*pi);
% u0(1,:) =1;
% u0(2,:) = 0;
% u0(3,:) = 10;
U = u0;



alpha = 1;

num = 5000;
f = zeros(num,alpha+1);
g= zeros(num,alpha+1);
for i = 1:num
     U1 = FVS_1( U,gamma,lambda );
%      disp((sum(U')-sum(U1'))./(sum(U')+1))
% axis([0,130,0,10])
%     plot(x,u0(1,:),x,U1(1,:));
%     f(i,:) =falpha_weight(U1,gamma,alpha,1);

    g(i,:) =falpha_weight2(U1,gamma,alpha,1);
%     f(i,:) =falpha_weight1(U1,gamma,alpha,1);
    
%     f(i,:) =falpha(U1,gamma,alpha,1);
%      f(i,:) =falpha1(U1,gamma,alpha,1);
%     plot(x,u0(2,:),x,U1(2,:));
%     plot(U1(1,:));
%     pause(0.0001)
     U=U1;
end
% % % % 
for j = 1:alpha+1
    subplot(2,1,j)
%     plot(log(abs(f(:,j))));
%     hold on 
    plot(log(abs(g(:,j))));
    set(gca,'FontName','Times New Roman','FontSize',10)
%     str = ['k=',num2str(f(1000,i)-f(1,i))];
%     text(500,log(abs(f(500,i))),str)
end