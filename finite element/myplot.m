function myplot(U1,U2,rho1,rho2,rho12,rho3)
N = size(U1,1);
X = linspace(0,0.1,N);
figure(1)
pcolor(X,X,U1);
colorbar;
title('x 位移','fontsize',15);
figure(2)
pcolor(X,X,U2);
title('y 位移','fontsize',15);
colorbar;
figure(3)
pcolor(X,X,rho1);
title('x 应力','fontsize',15);
colorbar;
figure(4)
pcolor(X,X,rho2);
title('y 应力','fontsize',15);
colorbar;
figure(5)
pcolor(X,X,rho12);
title('xy 应力','fontsize',15);
colorbar;
figure(6)
pcolor(X,X,rho3);
title('z 应力','fontsize',15);
colorbar;
end