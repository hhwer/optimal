function [rho1,rho2,rho12,rho3] = stress(U1,U2,lambda,mu)
%caculate    stress
%
%input
%       U1                  N*N_matrix               disp_x
%       U2                  N*N_matri                 disp_y
%       lambda,mu    scalar                         parameter
%   
%output
%       rho1                N*N_matrix               stress_x
%       rho2                N*N_matrix               stress_y
%       rho12              N*N_matrix               stress_xy
%       rho3                N*N_matrix               stress_z

N = size(U1,1);
h = 1/(N-1);
epi1 = zeros(N);
epi12 = zeros(N);
epi21 = zeros(N);
epi2 = zeros(N);
for i = 2:N-1
    epi1(:,i) = (U1(:,i+1)-U1(:,i-1))/(2*h);
    epi12(i,:) = (U1(i+1,:)-U1(i-1,:))/(2*h);
    epi21(:,i) = (U2(:,i+1)-U2(:,i-1))/(2*h);
    epi2(i,:) = (U2(i+1,:)-U2(i-1,:))/(2*h);
end
epi1(:,1) = (U1(:,2)-U1(:,1))/(h);
epi21(:,1) = (U2(:,2)-U2(:,1))/(h);
epi1(:,N) = (U1(:,N)-U1(:,N-1))/(h);
epi21(:,N) = (U2(:,N)-U2(:,N-1))/(h);
epi12(1,:) = (U1(2,:)-U1(1,:))/(h);
epi2(1,:) = (U2(2,:)-U2(1,:))/(h);
epi12(N,:) = (U1(N,:)-U1(N-1,:))/(h);
epi2(N,:) = (U2(N,:)-U2(N-1,:))/(h);
epi12 = (epi12+epi21)/2;
rho3 = epi1+epi2;
rho3 = lambda*rho3;
rho1 = rho3+2*mu*epi1;
rho2 = rho3+2*mu*epi2;
rho12 = 2*mu*epi12;
end