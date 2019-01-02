function [x, out] = lp_drs(c, A, b, opts, x0)
    proj = @(x) (x .* (x>0));
    [m, n] = size(A);
    % AAT_inv = inv(A*A');
    % AAT_invA = AAT_inv*A;
    % u0 = A\b;
    G = A'*inv(A*A');
    GA = G*A;
    G0 = inv(eye(n) - 2*GA);
    G1 = G0 * (eye(n) - GA);
    G2 = G0 * G * b;
    out = [];
    % ======= parameter =======
    t = 0.3;
    MAX_ITER = 5000;
    EPSILON = 1e-8;
    % ======= initialization ========
    y = zeros(n, 1);
    w = zeros(n, 1);
    x = zeros(n, 1);
%     xa = x0;
    % ======= iteration =======
    for iter = 1 : MAX_ITER
        x_old = x;
        y_old = y;
        % y = prox_tg(x-w)
        y = G1*(x - w - t*c) - G2;
        % x = porx_th(y+w)
        x = proj(y + w);
        % w = w + y -x
        w = w + y - x;
        if (norm(x-x_old, inf) < EPSILON) ...
            && (norm(y-y_old, inf) < EPSILON)
            break
        end
    end
    fprintf('DRS iters: %d\n', iter);
end