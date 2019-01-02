function [x, out] = lp_alm(c, A, b, opts, x0)
    proj = @(x) (x .* (x>0));
    out = [];
    [m, ~] = size(A);
%     [sigma, MAX_ITER, EPSILON, IN_MAX_ITER, IN_EPSILON] = opts;
    % ======= parameter =======
    sigma = 1;
    MAX_ITER = 2000;
    EPSILON = 1e-6;
    IN_MAX_ITER = 5000;
    IN_EPSILON = EPSILON;
    IN_STEP = 1e-2;
    % ======= initialization ========
    x = x0;
    y = zeros(m, 1);
    for iter = 1 : MAX_ITER
        x_old = x;
        % y = argmin_y{L(y,x_old)}
        for in_iter = 1 : IN_MAX_ITER
            in_step = IN_STEP;
            g = b - A*proj(x-sigma*(A'*y+c)); % gradient of objective
            y = y - in_step * g;
            if norm(g, inf) < IN_EPSILON
                break
            end
        end
        % x = Proj(x_old - sigma*(A'*y+c))
        x = proj(x - sigma*(A'*y+c));
        if norm(x - x_old, inf) < EPSILON
            break
        end
    end
    fprintf('ALM iters:%d\n', iter);
end