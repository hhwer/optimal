function [epi1,epi2,epi12] = strain(U1,U2)
%caculate  strian
%
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
end