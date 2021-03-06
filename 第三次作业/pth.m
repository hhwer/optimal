function [ x,f,trace ] = pth( Funcs,m,x,p,Rule )
%pth method
%input   
%       Funcs         function_handle
%                               Funcs(x)=[[f1(x),f2(x),...,fm(x)],{g1(x),g2(x),...,gm(x)}]                      
%       m               int     
%       x                n_vector
%       p                scalar   
%       Rule           struct   
%                           Rule.beta   scalar
%                                   more information see linesearch
%
%output
%       x               n_vector  
%       f               scalar      function_point
%       trace         vector     function value trace
trace = zeros(800,1);
trace(1) = max(Funcs(x));
u = ones(m,1);
g1 = 0;
n = length(x);
s = ones(n,1);
t =1;
for k = 1:4
    func = @(x)Ux_epi(Funcs,m,x,u,p,Rule.epi);
    flag = 0;
    for ite = 1:600
        [f,g,v,Rule.epi] = Ux_epi( Funcs,m,x,u,p,Rule.epi);
        y = g-g1;
        d = -(s'*y)/(y'*y)*g;
        
        if norm(y)<1e-20
            d = -g;
        end
        alpha = linesearch(func, x, f, g, d,Rule);
        if norm(g)<1e-6
            if flag==0 && k == 1
                flag = 1;
                n = length(x);
                d = 0.001*rand(n,1);
                alpha = 1;
            else
                disp([ite-1,k])
                break
            end
        end
        g1 = g;
        s = alpha*d;
        x = x+s;
        t = t+1;
        trace(t) = max(Funcs(x));
    end
    v0 = sum(v);
    if v0 == 0
        u = ones(m,1);
    else
        u = v./v0;
    end
    p = Rule.c*p;
end
f = max(Funcs(x));
end

