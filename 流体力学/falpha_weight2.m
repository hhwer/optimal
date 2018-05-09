function [ f ] = falpha_weight2(U,gamma,alpha,k)
[~,n,~] = size(U);
if k == 1
    rho = U(1,:);
    u = U(2,:)./U(1,:);
    T = (gamma-1)*( U(3,:) - u.^2/2.*rho );
    T0 = mean(T);
    sqT = sqrt(T);
    sqT0 = sqrt(T0);
    f = zeros(1,alpha+1);
    T1 = T+T0;
    u1 = u - mean(u);  

    A1 = rho./sqrt(T1)/sqrt(2*pi) .* exp(-u1.^2./T1/2);
    f(1) = mean(A1);    
    A0 = zeros(1,n);
    
    a1 = u1.*sqT0./T1;
    t2 = -T0./T1;
%     A2 =rho.* u1.*sqT0./  ( T1.^(3/2)*sqrt(2*pi)) .*exp(-u1.^2./T1/2);
%     f(2) = mean(A2) ;
    for i = 1:alpha
% %         A1 = u1.*sqT0.*A1./T1  -T0./T1*(i-1).*A0;
        A2 = a1.*A1 + (i-1)*t2.*A0; 
        A0 = A1;
        A1 = A2;
        temp = A1;
        f(1+i) = mean(temp) /(factorial(i)) ;
    end
end
end