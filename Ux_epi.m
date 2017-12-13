function [ 	F,g,v,epi ] = Ux_epi( Funcs,m,x,u,p,epi)
%calculate   U(x,u,p,epi)
%input   
%       Funcs         function_handle
%                               Funcs(x)=[[f1(x),f2(x),...,fm(x)],{g1(x),g2(x),...,gm(x)},{G1(x),G2(x),...,Gm(x)}]                      
%       m               int     
%       x                n_vector
%                      
%
%output
%       F               scalar      function_point
%       g               n_vector  gradient
%                    
f = Funcs(x);
F = 0;
f0 = max(f);
n = length(x);
g = zeros(n,1);
v = zeros(m,1);
M = f0-epi;
q = sign(M) * p;
if M == 0
    return
% if M == 0
%     epi = epi-1;
%     M = 1;
% end
elseif M > 0
    for i =1:m
        if f(i) > epi
            F = F + u(i)*((f(i)-epi)/M)^q;
        end
    end
    if nargout == 1
        F = F^(1/q);        
        F = M * F;
    else
        [~,g0] = Funcs(x); 
        for i = 1:m
            if f(i) > epi
                v(i) = u(i)*((f(i)-epi)/M)^(q-1);
                g = g + v(i)*g0{i};
            end
        end
        g = F^(1/q  - 1) * g;
        F = F^(1/q);        
        F = M * F;
    end
else
    for i = 1:m
        F = F + u(i)*((f(i)-epi)/M)^q;
    end
    if nargout == 1
        F = F^(1/q);        
        F = M * F;
    else
        [~,g0] = Funcs(x); 
        for i = 1:m
            v(i) = u(i)*((f(i)-epi)/M)^(q-1);
            g = g + v(i)*g0{i};
        end
        g = F^(1/q  - 1) * g;
        F = F^(1/q);        
        F = M * F;
    end
end    

end

