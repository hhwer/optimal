function [E1,E2,E12] = compute_strain(U1,U2)
N = size(U1,1);
h = 1/(N-1);
diff11 = zeros(N);
diff12 = zeros(N);
diff21 = zeros(N);
diff22 = zeros(N);
for i = 2:N-1
    diff11(:,i) = (U1(:,i+1)-U1(:,i-1))/(2*h);
    diff12(i,:) = (U1(i+1,:)-U1(i-1,:))/(2*h);
    diff21(:,i) = (U2(:,i+1)-U2(:,i-1))/(2*h);
    diff22(i,:) = (U2(i+1,:)-U2(i-1,:))/(2*h);
end
diff11(:,1) = (U1(:,2)-U1(:,1))/(h);
diff21(:,1) = (U2(:,2)-U2(:,1))/(h);
diff11(:,N) = (U1(:,N)-U1(:,N-1))/(h);
diff21(:,N) = (U2(:,N)-U2(:,N-1))/(h);
diff12(1,:) = (U1(2,:)-U1(1,:))/(h);
diff22(1,:) = (U2(2,:)-U2(1,:))/(h);
diff12(N,:) = (U1(N,:)-U1(N-1,:))/(h);
diff22(N,:) = (U2(N,:)-U2(N-1,:))/(h);
E1 = diff11;
E2 = diff22;
E12 = (diff12+diff21)/2;
end