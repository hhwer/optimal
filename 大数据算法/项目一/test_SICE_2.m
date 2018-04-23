clear
[S ,omega]= get_model(1);
rho = 0.01;
S1 = ones(30);
I = eye(30);
cvx_begin
    variable X(30,30) symmetric
    X == semidefinite(30)
    minimize trace(S1*abs(X))
    subject to
        trace(S1*abs(S*X-I)) < rho
cvx_end


