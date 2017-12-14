function [ x,f ] = smooth( Funcs,m,x,mu,Rule )
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

for k = 1:1000
    [f,g,G] = fx_mu( Funcs,m,x,mu);
    d = -G\g;
    if d==0
        alpha = 0;
    else
        func = @(x)(fx_mu(Funcs,m,x,mu));
        alpha = linesearch(func, x, f, g, d,Rule);
    end
    x1 = x + alpha*d;
    err = abs(g'*d);
    disp(err);
    if err < 1e-6
        break
    end
    mu = mu*Rule.beta;
    x = x1;
end

end

