function [ f ] = falpha_weight1(U,gamma,alpha,k)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[~,n,~] = size(U);
if k == 1
    rho = U(1,:);
    u = U(2,:)./U(1,:);
    T = (gamma-1)*( U(3,:)./rho - u.^2/2 );
    T0 = mean(T);
    

    sqT = sqrt(T);
    sqT0 = sqrt(T0);
    f = zeros(1,alpha+1);
    
    T1 = T+T0;
    
    u1 = u - mean(u);   %%%����



    A1 = sqrt(2*pi)*sqT*sqT0./sqrt(T1);
    A1 = A1 .* exp(-u1.^2./T1/2);

    A0 = zeros(1,n);
    c = sqrt(2*pi)*sqT;
    c = rho./c;
    temp = c.*A1;
    f(1) = mean(temp)/sqT0/sqrt(pi);
    
    
    a1 = u1.*sqT0./T1;
    t2 = -T0./T1;
    
    for i = 1:alpha
%         A1 = u1.*sqT0.*A1./T1  -T0./T1*(i-1).*A0;
        A1 = a1.*A1 + t2.*A0; 
        A0 = A1;
        temp = c.*A1;
        f(1+i) = mean(temp) /(factorial(i)) /sqT0/sqrt(pi);
    end

elseif k == 2
    rho = U(1,:,:);
    u = U(2,:,:)./rho;
    v = U(3,:,:)./rho;
    T = (gamma-1)*( U(4,:,:)./rho - u.^2/2-v.^2/2 );
    
    u1 = u - mean(mean(u)); 
    v1 = v - mean(mean(v));
    
    T0 = mean(mean(T));
    T1 = T+T0;
    sqT = sqrt(T);
    sqT0 = sqrt(T0);
    f = zeros(alpha+1);
    A = zeros(alpha+2,n,n);
    B = zeros(alpha+2,n,n);
    A(1,:,:) = zeros(n,n);
    A(2,:,:) = sqrt(2*pi)*sqT*sqT0./sqrt(T1);
    A(2,:,:)  = A(2,:,:)  .* exp(-u1.^2./T1);
    B(1,:,:) = zeros(n,n);
    B(2,:,:) = sqrt(2*pi)*sqT*sqT0./sqrt(T1);
    B(2,:,:)  = B(2,:,:)  .* exp(-v1.^2./T1);

    c = 2*pi*T;
    temp = rho./c.*A(2,:,:).*B(2,:,:);
    f(1,1) = mean(mean(temp))/T0/pi;
    
    a1 = u1.*sqT0./T1;
    t2 = -T0./T1;
    b1 = v1.*sqT0./T1;
    
    for i = 1:alpha
        A(i+2,:,:) = a1.*A(i+1,:,:) +t2.*(i-1).*A(i,:,:);
        B(i+2,:,:) = b1.*B(i+1,:,:) +t2.*(i-1).*B(i,:,:);
    end
    % % A(i+2,:,:)�洢��i��A  i=0,1,2,3... ��A(1,:,:)Ϊ0,ֻ������ڵ�   ��Ӧ��f(i+1)��Ϊ��i��f
    
    for i = 1:alpha
        for j = 1:alpha
            temp = rho./c.*A(i+2,:,:).*B(j+2,:,:);
            f(i+1,j+1) = mean(mean(temp))/(2^i*factorial(i))/(2^j*factorial(j))/ T0/pi;
        end
        temp = rho./c.*A(i+2,:,:).*B(2,:,:);
        f(i+1,1) = mean(mean(temp))/(2^i*factorial(i))/T0/pi;
        temp = rho./c.*A(2,:,:).*B(i+2,:,:);
        f(1,i+1) = mean(mean(temp))/(2^i*factorial(i))/T0/pi;
    end
    
else
    
    
    
end



end