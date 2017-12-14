function [ y,g,G ] = fx_mu( Funcs,m,x,mu)
%calculate   f(x,mu)
%input   
%       Funcs         function_handle
%                               Funcs(x)=[[f1(x),f2(x),...,fm(x)],{g1(x),g2(x),...,gm(x)},{G1(x),G2(x),...,Gm(x)}]                      
%       m               int     
%       x                n_vector
%       mu             scalar   
%
%output
%       y               scalar      function_point
%       g               n_vector  gradient
%       G               n*n_matrix    Hessen matrix
lambda = zeros(m,1);
f = Funcs(x);
f0 = max(f);
y = 0;
for i = 1:m
    lambda(i) = exp((f(i)-f0)/mu);
    y = y+lambda(i);
end
for i = 1:m
    lambda(i) = lambda(i)/y;
end
y = mu*log(y);
y = y + f0;
if nargout == 2
    n = length(x);
    g = zeros(n,1);
    [~,g0] = Funcs(x);
    for i = 1:m
        g = g + lambda(i)*g0{i};
    end
end
if nargout == 3
    n = length(x);
    g = zeros(n,1);
    G = zeros(n);
    [~,g0,G0] = Funcs(x);
    for i =1:m
        g = g+lambda(i)*g0{i};
        G = G + lambda(i)*G0{i} + lambda(i)/mu*g0{i}*g0{i}';
    end
    G = G - 1/mu*(g*g');
end

end

