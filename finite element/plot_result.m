function plot_result(U1,U2,E1,E2,E12,S1,S2,S12)
N = size(U1,1);
X = linspace(0,0.1,N);
figure(1)
pcolor(X,X,U1);
colorbar;
title('x 方向位移','fontsize',19);
figure(2)
pcolor(X,X,U2);
title('y 方向位移','fontsize',19);
colorbar;
figure(3)
pcolor(X,X,E1);
title('x 方向正应变','fontsize',19);
colorbar;
figure(4)
pcolor(X,X,E2);
title('y 方向正应变','fontsize',19);
colorbar;
figure(5)
pcolor(X,X,E12);
title('xy 方向切应变','fontsize',19);
colorbar;
figure(6)
pcolor(X,X,S1);
title('x 方向正应力','fontsize',19);
colorbar;
figure(7)
pcolor(X,X,S2);
title('y 方向正应力','fontsize',19);
colorbar;
figure(8)
pcolor(X,X,S12);
title('xy 方向切应力','fontsize',19);
colorbar;
end