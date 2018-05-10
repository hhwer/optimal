
tau = 0.0002;
% tau = 1e-6;
gamma = 1.5;
n = 1000;
h = 2/n;
lambda = tau/h;
x = -1:2/n:1;
x = x(1:n);




%case 1
% u0 = zeros(3,n);
% u0(1,:) =0.2* cos(x*pi)+1;
% u0(2,:) = 0.3*sin(x*pi);
% u0(3,:) = 10+0.2*cos(x*pi);
% U = u0;

% %case 2
% u0 = zeros(3,n);
% u0(1,:) =0.1* cos(x*pi)+1;
% u0(2,:) = sin(x*pi);
% u0(3,:) = 10+0.2*cos(x*pi);
% U = u0;

%%case 3
% u0 = zeros(3,n);
% u0(1,:) =0.1* cos(x*pi)+1;
% u0(2,:) = 10*sin(x*pi);
% u0(3,:) = 10+0.2*cos(x*pi);
% U = u0;

% % % % % case 4
u0 = zeros(3,n);
for i = 1:n
    if i < n/4 || i>n*3/4
        u0(1,i)=0.5;
        u0(2,i)=u0(1,i)*0.689;
    else
        u0(1,i)=0.45;
        u0(2,i)=0;        
    end
    u0(3,i)=10+0.5*u0(2,i)^2/u0(1,i);
end
U = u0;

alpha = 3;

num = 10000;
f = zeros(num,alpha+1);
g= zeros(num,alpha+1);
for i = 1:num
     U1 = FVS_1( U,gamma,lambda );
%      disp((sum(U')-sum(U1'))./(sum(U')+1))
%     plot(x,u0(1,:),x,U1(1,:));
%     f(i,:) =falpha_weight(U1,gamma,alpha,1);
    f(i,:) =falpha_weight1(U1,gamma,alpha,1);
%     pause(0.0001)
     U=U1;
end
% % % % 
t = tau*(1:num);
for j = 1:alpha+1
    subplot(2,2,j)
    plot(t,log(abs(f(:,j))));
    title(['f',num2str(j-1)])
    xlabel('t(s)')
    set(gca,'FontName','Times New Roman','FontSize',10)
end
suptitle(['case3 n=',num2str(n),' tau=',num2str(tau)]);
fprintf(['d1-3-',num2str(n),'\n']);