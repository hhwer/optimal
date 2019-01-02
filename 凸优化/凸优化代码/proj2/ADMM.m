function [x, out] = ADMM(c, A, b, opts, x0)
    [m,~] = size(A);
    out = [];
    t = 1;
    T = 20000;
    ep = opts.ep;
    y = randn(m, 1);
    s = c;
    x = x0;
    B = A*A';
    for i = 1:T
        y1 = (B)\(b/t+A*(c-s-x));
        s = proj(c-A'*y1-x);
        x1 = x + (A'*y1+s-c);
        if norm(x1-x, inf)<ep && norm(y1-y,inf)<ep
            x = x1;
            break;
        end
        x = x1;
        y = y1;
    end
    function w = proj (u)
        w = u.*(u>0);
    end
end