function [ x,f ] = smooth( Funcs,m,x,mu,Rule )
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

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

