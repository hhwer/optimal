function [x, out] = lp_admm(c, A, b, opts, x0)
    proj = @(x) (x .* (x>0));
    AAT_inv = inv(A*A');
    [m, n] = size(A);
    out = [];
    % ======= parameter =======
    beta = 1;
    MAX_ITER = 5000;
    EPSILON = 1e-8;
    % ======= initialization ========
    y = zeros(m, 1);
    s = c;
    x = x0;
    % ======= iteration =======
    for iter = 1 : MAX_ITER
        x_old = x;
        y_old = y;
        y = AAT_inv * (b/beta + A*(c-s-x));
        s = proj(c - A'*y - x);
        x = x + (A'*y + s - c);
        if (norm(x-x_old, inf) < EPSILON) ...
            && (norm(y-y_old, inf) < EPSILON)
            break
        end
    end
    fprintf('ADMM iters: %d\n', iter);
end