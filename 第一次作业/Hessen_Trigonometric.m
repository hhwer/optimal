function [ C ] = Hessen_Trigonometric( x )
%UNTITLED13 此处显示有关此函数的摘要
%   此处显示详细说明
n = size(x);
n = n(1);
C = zeros(n,n);
r = zeros(n,1);
for i = 1:n
    r(i) = n + i*(1 - cos(x(i))) - sin(x(i));
    for j = 1:n 
        r(i) = r(i) - cos(x(j));
    end
end

for i = 1:n
    for j = 1:n
        s = 0;
        if i == j
            for k = 1:n
                if k == i
                    a = (sin(x(i))*(i+1)-cos(x(i)));
                    b = (i+1)*cos(x(i)) + sin(x(i));
                else
                    a = sin(x(i));
                    b = cos(x(i));
                end

                a = 2*a^2+2*r(k)*b;
                s = s+a;
            end
        else
            for k = 1:n
                if k == i
                    a = (sin(x(i))*(i+1)-cos(x(i)));
                    b = sin(x(j));
                elseif k == j
                    a = (sin(x(j))*(j+1)-cos(x(j)));
                    b = sin(x(i));
                else
                    a = sin(x(i));
                    b = sin(x(j));
                end
                a = 2*a*b;
                s = s+a;
            end
        end
        C(i,j) = s;
    end
end
            


end

