function [x, out] = lp_cvx_mosek(c, A, b, opts, x0)
    cvx_solver mosek;
    out = [];
    [~, n] = size(A);
    cvx_begin
        variable x(n);
        minimize( c'*x );
        subject to
            A*x == b;
            x >= 0;
    cvx_end
end