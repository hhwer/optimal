function k = kernel(flag, lambda)
if flag == 1
    % Epanechnikov
    D = @(t)((abs(t)<=1)*3/4.*(1-t.*t));
    k = @(x,y)(D(nrm2(x-y)/lambda));
elseif flag == 2
    % Gauss
    k = @(x,y)(exp(-(norm(x,y)^2)/(2*lambda^2)))/...
        (sqrt(2*pi*lambda^2))^length(n);
elseif flag ==3
    % cubic
    D = @(t)((abs(t)<=1)*((1-abs(t)^3)^3));
    k = @(x,y)(D(norm(x-y)/lambda));
end
end