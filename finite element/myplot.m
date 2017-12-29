function myplot(U1,U2,rho1,rho2,rho12,rho3)
N = size(U1,1);
X = linspace(0,0.1,N);
figure(1)
pcolor(X,X,U1);
colorbar;
title('x λ��','fontsize',15);
figure(2)
pcolor(X,X,U2);
title('y λ��','fontsize',15);
colorbar;
figure(3)
pcolor(X,X,rho1);
title('x Ӧ��','fontsize',15);
colorbar;
figure(4)
pcolor(X,X,rho2);
title('y Ӧ��','fontsize',15);
colorbar;
figure(5)
pcolor(X,X,rho12);
title('xy Ӧ��','fontsize',15);
colorbar;
figure(6)
pcolor(X,X,rho3);
title('z Ӧ��','fontsize',15);
colorbar;
end