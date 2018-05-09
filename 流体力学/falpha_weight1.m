function [ f ] = falpha_weight1(U,gamma,alpha,k)
%       计算概率下的f
%input
%           U               (k+2)*n^k_vector            
%           gamma      float                                              
%           k                int                          维数
%           alpha         int
% output
%           f                 vector                    f=[f0,f1,...,f_alpha]      
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
    beta = sqT0*sqrt(2*pi);
    A1 = sqrt(2*pi)*sqT*sqT0./sqrt(T1);
    A1 = A1 .* exp(-u1.^2./T1/2);
    A0 = zeros(1,n);
    c = rho./ (sqrt(2*pi)*sqT);
    temp = c.*A1;
    f(1) = mean(temp)/beta;
    a1 = u1.*sqT0./T1;
    t2 = -T0./T1;
    
   
    for i = 1:alpha
% %         A1 = u1.*sqT0.*A1./T1  -T0./T1*(i-1).*A0;
        A2 = a1.*A1 + (i-1)*t2.*A0; 
        A0 = A1;
        A1 = A2;
        temp = c.*A1;
        f(1+i) = mean(temp) /(factorial(i)) /beta;
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
    
    beta = 2*T0*pi;
    
    a1 = u1.*sqT0./T1;
    t2 = -T0./T1;
    b1 = v1.*sqT0./T1;
    
    for i = 1:alpha
        A(i+2,:,:) = a1.*A(i+1,:,:) +t2.*(i-1).*A(i,:,:);
        B(i+2,:,:) = b1.*B(i+1,:,:) +t2.*(i-1).*B(i,:,:);
    end
    % % A(i+2,:,:)存储第i个A  i=0,1,2,3... 而A(1,:,:)为0,只是虚拟节点   对应的f(i+1)中为第i个f
    
    for i = 1:alpha
        for j = 1:alpha
            temp = rho./c.*A(i+2,:,:).*B(j+2,:,:);
            f(i+1,j+1) = mean(mean(temp))/(factorial(i))/(factorial(j))/ beta;
        end
        temp = rho./c.*A(i+2,:,:).*B(2,:,:);
        f(i+1,1) = mean(mean(temp))/(factorial(i))/beta;
        temp = rho./c.*A(2,:,:).*B(i+2,:,:);
        f(1,i+1) = mean(mean(temp))/(factorial(i))/beta;
    end
    
else
    rho = U(1,:,:,:);
    u = U(2,:,:,:)./rho;
    v = U(3,:,:,:)./rho;
    w = U(4,:,:,:)./rho;
    T = (gamma-1)*( U(4,:,:,:)./rho - u.^2/2-v.^2/2 -w.^2/2);
    
    u1 = u - mean(mean(mean(u))); 
    v1 = v - mean(mean(mean(v)));
    w1 = w - mean(mean(mean(w)));
    
    T0 = mean(mean(mean(T)));
    T1 = T+T0;
    sqT = sqrt(T);
    sqT0 = sqrt(T0);
    f = zeros(alpha+1);
    A = zeros(alpha+2,n,n,n);
    B = zeros(alpha+2,n,n,n);
    C = zeros(alpha+2,n,n,n);
    A(1,:,:,:) = zeros(n,n,n);
    A(2,:,:,:) = sqrt(2*pi)*sqT*sqT0./sqrt(T1);
    A(2,:,:,:)  = A(2,:,:,:)  .* exp(-u1.^2./T1);
    B(1,:,:,:) = zeros(n,n,n);
    B(2,:,:,:) = sqrt(2*pi)*sqT*sqT0./sqrt(T1);
    B(2,:,:,:)  = B(2,:,:,:)  .* exp(-v1.^2./T1);
    C(1,:,:,:) = zeros(n,n,n);
    C(2,:,:,:) = sqrt(2*pi)*sqT*sqT0./sqrt(T1);
    C(2,:,:,:)  = C(2,:,:,:)  .* exp(-w1.^2./T1);

    beta = (sqT0*sqrt(2*pi))^3;
    
    c = (2*pi)^(3/2)*T.*sqT;
    temp = rho./c.*A(2,:,:,:).*B(2,:,:,:)*C(3,:,:,:);
    f(1,1,1) = mean(mean(mean(temp)))/beta;
    
    a1 = u1.*sqT0./T1;
    t2 = -T0./T1;
    b1 = v1.*sqT0./T1;
    c1 = w1.*sqT0./T1;
    
    for i = 1:alpha
        A(i+2,:,:,:) = a1.*A(i+1,:,:,:) +t2.*(i-1).*A(i,:,:,:);
        B(i+2,:,:,:) = b1.*B(i+1,:,:,:) +t2.*(i-1).*B(i,:,:,:);
        C(i+2,:,:,:) = c1.*C(i+1,:,:,:) +t2.*(i-1).*C(i,:,:,:);
    end
    % % A(i+2,:,:)存储第i个A  i=0,1,2,3... 而A(1,:,:)为0,只是虚拟节点   对应的f(i+1)中为第i个f
    
    for i = 1:alpha
        for j = 1:alpha
            for k = 1:alpha
                temp = rho./c.*A(i+2,:,:,:).*B(j+2,:,:,:)*C(k+2,:,:,:);
                f(i+1,j+1,k+1) = mean(mean(mean(temp)))/(factorial(i))/(factorial(j))/factorial(k)/ beta;
            end
            temp = rho./c.*A(i+2,:,:,:).*B(j+2,:,:,:)*C(2,:,:,:);
            f(i+1,j+1,1) = mean(mean(mean(temp)))/(factorial(i))/(factorial(j))/ beta;
            temp = rho./c.*A(i+2,:,:,:).*B(2,:,:,:)*C(j+2,:,:,:);
            f(i+1,1,j+1) = mean(mean(mean(temp)))/(factorial(i))/(factorial(j))/ beta;
            temp = rho./c.*A(2,:,:,:).*B(i+2,:,:,:)*C(j+2,:,:,:);
            f(1,i+1,j+1) = mean(mean(mean(temp)))/(factorial(i))/(factorial(j))/ beta;
        end
        temp = rho./c.*A(i+2,:,:,:).*B(2,:,:,:)*C(2,:,:,:);
        f(i+1,1,1) = mean(mean(mean(temp)))/(factorial(i))/ beta;
        temp = rho./c.*A(2,:,:,:).*B(i+2,:,:,:)*C(2,:,:,:);
        f(1,i+1,1) = mean(mean(mean(temp)))/(factorial(i))/ beta;        
        temp = rho./c.*A(2,:,:,:).*B(2,:,:,:)*C(i+2,:,:,:);
        f(1,1,i+1) = mean(mean(mean(temp)))/(factorial(i))/ beta;        
    end
    
    
end



end