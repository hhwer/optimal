function [ x,f,trace ] = smooth( Funcs,m,x,mu,Rule )
%smooth method by xu
%input   
%       Funcs         function_handle
%                               Funcs(x)=[[f1(x),f2(x),...,fm(x)],{g1(x),g2(x),...,gm(x)},{G1(x),G2(x),...,Gm(x)}]                      
%       m               int     
%       x                n_vector
%       mu             scalar   
%       Rule           struct   
%                           Rule.beta   scalar
%                                   more information see linesearch
%
%output
%       x               n_vector  
%       f               scalar      function_point
%       trace         vector     function value trace
trace = zeros(1000,1);
g1 = 0;
n = length(x);
s = ones(n,1);
trace(1) =  max(Funcs(x));
t = 1;
for k = 1:100
    [f,g,G] = fx_mu( Funcs,m,x,mu);
    y = g-g1;
    if rcond(G) > 1e-16
        d = -G\g;
    else
        d = -(s'*y)/(y'*y)*g;
    end

    if d==0
        alpha = 0;
    else
        func = @(x)(fx_mu(Funcs,m,x,mu));
        alpha = linesearch(func, x, f, g, d,Rule);
    end
    s = alpha*d;
    x1 = x + s;
    t = t+1;
    trace(t) =  max(Funcs(x1));
    g1=g;
    err = abs(g'*d);
    disp(err);
    if err < 1e-20
        break
    end
    mu = mu*Rule.beta;
    x = x1;
end

end

