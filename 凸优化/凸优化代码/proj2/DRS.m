function [x, out] = DRS(c, A, b, opts, x0)
    [~, n] = size(A);
    W = A'*((A*A')\A);
    Q = (eye(n)-2*W)\(eye(n)-W);
    QQ = (eye(n)-2*W)\(A'*((A*A')\b));
    out = [];
    t = 0.03;
    T = 50000;
    ep = opts.ep;
    y = zeros(n, 1);
    z = zeros(n, 1);
    x = x0;
    for i = 1:T
%         y1 = Q*(x-w-t*c)-QQ;
%         x1 = Q*(z-t*c)-QQ;
%         y1 = proj(2*x1 - z);
        x1 = proj(z);
        y1 = Q*(2*x1-z-t*c)-QQ;
        z = z + y1 - x1;
        if norm(x1-x,inf)<ep && norm(y1-y,inf)<ep
            x = x1;
            break;            
        end
        x = x1;
        y = y1;
    end
    function w = proj (u)
        w = u.*(u>0);
    end
% disp (i);
end