function [ f ] = falpha(U,gamma,alpha,k)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
[~,n] = size(U);
if k == 1
    if alpha == 0
        f = mean(U(1,:));
        %     elseif n == -1
        %         T = (gamma-1)*( U(3,:)./U(1,:) - U(2,:).^2/(U(1,:)^2)/2 );
        %            T0 = mean(T);
        %         f = 2*mean(U(2,:))/sqrt(T0);
        %         f = [mean(U(1,:)),f];
    else
        rho = U(1,:);
        u = U(2,:)./U(1,:);
        T = (gamma-1)*( U(3,:)./rho - u.^2/2 );
        T0 = mean(T);
        sqT = sqrt(T);
        sqT0 = sqrt(T0);
        f = zeros(1,alpha+1);
        f(1) = mean(u);
        %         f(2) = 2*mean(U(2,:))/sqrt(T0);
        A1 = sqrt(2*pi)*sqT;
        A0 = zeros(1,n);
        c = sqrt(2*pi)*sqT;
        
        for i = 2:alpha+1
            A1 = 2*u./sqT0.*A1 + (4*T-2*T0)./T0*(i-1).*A0;
            A0 = A1;
            temp = rho./c.*A1;
            f(i) = mean(temp);
        end
    end
end

end

