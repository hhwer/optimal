function [ x,f ] = pth( Funcs,m,x,p,Rule )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
u = ones(m,1);
for k = 1:7
    func = @(x)Ux_epi(Funcs,m,x,u,p,Rule.epi);
    flag = 0;
    for ite = 1:400
        [f,g,v,Rule.epi] = Ux_epi( Funcs,m,x,u,p,Rule.epi);
        d = -g;
        alpha = linesearch(func, x, f, g, d,Rule);
        if norm(g)<1e-8
            if flag==0 && k == 1
                flag = 1;
                n = length(x);
                d = 0.001*rand(n,1);
                alpha = 1;
            else
                break
                end
        end
        
        x = x+alpha*d;
    end
    v0 = sum(v);
    if v0 == 0;
        u = ones(m,1);
    else
        u = v./v0;
    end
    p = Rule.c*p;
end
f = max(Funcs(x));
end

