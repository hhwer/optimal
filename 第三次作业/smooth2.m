function [ x0,f,trace] = smooth2( Funcs,m,xb,p,Rule )
%smooth method2 learned
%input   
%       Funcs         function_handle
%                               Funcs(x)=[[f1(x),f2(x),...,fm(x)],{g1(x),g2(x),...,gm(x)},{G1(x),G2(x),...,Gm(x)}]                      
%       m               int     
%       xb                n_vector
%       p             scalar     p>=2
%       Rule           struct   
%                           Rule.theta   scalar  admit = 0.9
%                           Rule.sigma  scalar  admit = 0.1
%                                   more information see linesearch
%
%output
%       x0               n_vector  
%       f               scalar      function_point
%       trace         vector     function value trace
xalpha = 10^1*max(max(Funcs(xb)),1);
trace = zeros(1000,1);
trace(1) = max(Funcs(xb));
u = ones(m,1);
n = length(xb);
w = xb;
t = 1;
if ~isfield(Rule,'theta')
    Rule.theta = 0.9;
end
if ~isfield(Rule,'sigma')
    Rule.sigma = 0.1;
end
epi = 1;
for ite = 1:150
    if max(Funcs(xb)) <= max(Funcs(w))   %%step 1
        x0 = xb;
        z0 = max(Funcs(xb));
    else
        x0 = w;
        z0 = max(Funcs(w));
    end
    g1 = 0;
    s = ones(n+1,1);
    for  k = 0:200
        xz = [x0;z0];
        [P0,DxP,DzP,c,Df] = Pxz_epi( Funcs,m,xz,epi,xalpha,p);
        g = [DxP;DzP];
        if norm(g) < 1e-16   %%step 2
            
            if norm(c) < 1e-16
               f = max(Funcs(x0));
                return
            else
                epi = Rule.theta * epi;
                w = x0;
                break
            end
        end
        
        if epi*norm(Df'*DxP-u*DzP)^2 >= Rule.sigma * norm(c)^2 && k>0   %%step 3
            epi = Rule.theta * epi;
            w = x0;
            break
        end
        
        func = @(xz)Pxz_epi(Funcs, m , xz, epi, xalpha,p);
        y1 = g-g1;
        d = -(s'*y1)/(y1'*y1)*g;
        alpha = linesearch(func, xz, P0, g, d,Rule);
        xz1 = xz +alpha*d;
        y = xz1(1:n);
        r = xz1(n+1);
        if max(Funcs(y)) > max(Funcs(w)) - epi
            epi = Rule.theta*epi;
            w = x0;
            break
        else
            x0 = y;
            z0 = r;
            s = alpha*d;
            g1 = g;
        end
        t = t+1;
        trace(t) = max(Funcs(x0));
    end
    
    
        

end

f = max(Funcs(x0));
end

