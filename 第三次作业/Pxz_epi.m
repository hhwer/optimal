function [ P,DxP,DzP,c,Df ] = Pxz_epi( Funcs,m,xz,epi,xalpha,p)
%calculate   P(x,z,epi)
%input   
%       Funcs         function_handle
%                               Funcs(x)=[[f1(x),f2(x),...,fm(x)],{g1(x),g2(x),...,gm(x)},{G1(x),G2(x),...,Gm(x)}]                      
%       m               int     
%       xz                n+1_vector   [x;z]
%       epi             scalar   
%       xalpha        scalar
%       p                 scalar
%output
%       P               scalar      function_point
%       DxP           n_vector  partial x of P
%       DzP            scalar    partial z of P
%       c                n_vector
%       Df              n*m matrix      [g1(x),g2(x),...,gm(x)]

n = length(xz)-1;
x = xz(1:n);
z = xz(n+1);
[f,g] = Funcs(x);
F = diag(f);
r = 0;
u = ones(m,1);
for i = 1:m
    r = r+ max(0,f(i)-z)^p;
end
Df = zeros(n,m);
for i = 1:m
    Df(:,i) = g{i};
end
M = Df'*Df + (F-z*eye(m))^2 + u*u'+r*eye(m);
lambda = M\u;
b = xalpha - f;
c = f - z - min(0,f-z+1/2*epi*(b.*r));
P = z + lambda'*c +1/epi*c'./b'*c;
if nargout > 1
    [~,~,G] = Funcs(x);
    Dxlambda = 2*lambda.*(F-z*eye(m))*Df';
    A = zeros(n);
    B = zeros(1,n);
    for i  = 1:m
        A = A + lambda(i)*G{i};
        B = B + max(0,f(i)-z)^(p-1)*g{i}';
        ei = zeros(m,1);
        ei(i) = 1;
        Dxlambda = Dxlambda + ei*lambda'*Df'*G{i};
    end
    Dxlambda = Dxlambda + Df'*A + p*lambda*B;
    Dxlambda = -M\Dxlambda;
    DxP = Df*lambda + Dxlambda'*c + 2/epi*Df*(c./b) + 1/epi*Df*(c./b).^2;
    
    a = 0;
    for i = 1:m
        a = a + max(0,f(i)-z)^(p-1);
    end
    a = 2*z - p*a;
    a = F - a*eye(m);
    a = a*lambda;
    Dzlambda = M\a;
    DzP = 1 - lambda'*u + Dzlambda'*c - 2/epi*u'./b'*c;
end



end

