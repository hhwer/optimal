errX = @(x1, x2) norm(x1-x2)/(1+norm(x1));
F = @(X)-log_det(X)+trace(S*X)+rho*trace(S1*abs(X));
errF = @(x1, x2)(F(x1)-F(x2))/(1+abs(F(X1)));
% clear
% % % cvx for 3.1 通过get_model(k) k=1,2获取两个model的数据
 [S,omega ]= get_model(1);  
rho = 10;
S1 = ones(30);
tic;
cvx_begin
    variable X(30,30) symmetric
    X == semidefinite(30)
    minimize (-log_det(X)+trace(S*X)+rho*trace(S1*abs(X)))
cvx_end
t1 = toc;


% % % threating for 3.1
tic;

gap = zeros(10000,1);
epi = 1e-4;
zeta = 1;
c = 0.85;
X0 = zeros(30);
for i = 1:30
    X0(i,i) = 1/(S(i,i)+rho);
end

X0_inverse = X0^(-1);
delta = 2*epi;
for ite = 1:10000
    for k = 1:500
        X1 = eta(X0-zeta*(S-X0_inverse),rho*zeta);
        [L,q] = chol(X1);
        if q ~= 0
        elseif func(X1,S) > Q(X1,X0,X0_inverse,zeta,S)
        else
            break
        end
        zeta = zeta*c;
    end
    if k == 500
        fprintf('not attain the epsilon\n');
        break
    end
    X1_inverse = L^(-1);
    X1_inverse = X1_inverse*X1_inverse';
    C = X1-X0;
    Y = X0_inverse - X1_inverse;
    zeta = trace(C*C)/trace(C*Y);
    if (zeta == inf) | (isnan(zeta))
        zeta = 1;
    end
    
    U = zeros(30);
    for i = 1:30
        for j = 1:30
            U(i,j) = min(max(1/X1(i,j)-S(i,j),-rho),rho);
        end
    end
    delta = -log(det(S+U)) - 30 - log(det(X1)) + trace(S*X1) + rho*trace(S1*abs(X1));
    gap(ite) = delta;
    disp(delta)
    if delta < epi
        break
    end
    X0 = X1;
    X0_inverse = X1_inverse;
end


t2 = toc;



fprintf('%5.2f  & %3.2e & %5.2f & %3.2e   &   %3.2e & %3.2e & %d \\\\ \n', ...
       t1,F(X),t2,F(X),errF(X,X1),errX(X,X1),ite);

% % % % % cvx for 3.2
% % % I = eye(30);
% % % cvx_begin
% % %     variable X2(30,30) symmetric
% % %     X2 == semidefinite(30)
% % %     minimize trace(S1*abs(X2))
% % %     subject to
% % %         trace(S1*abs(S*X2-I)) <= rho
% % % cvx_end



% % % % % a subgradient method for 3.1
% % % X0 = eye(30);
% % % Z = zeros(30);
% % % Z(X0>0) = 1;
% % % Z(X0<0) = -1;
% % % G0 = -X0^(-1)+S+rho*Z;
% % % X1 = X0-G0;
% % % s = vec(X1-X0);
% % % for k = 1:10000
% % %     Z = zeros(30);
% % %     Z(X1>0) = 1;
% % %     Z(X1<0) = -1;
% % %     G1 = -X1^(-1)+S+rho*Z;
% % %     y = vec(G1-G0);
% % %     alpha = s'*y/(y'*y);
% % %     X0 = X1;
% % %     S = -alpha*G1;
% % %     for i = 1:100
% % %         if func(X0+S,S,S1,rho) < func(X0,S,S1,rho) 
% % %             break
% % %         end
% % %         S = 0.8*S;
% % %     end
% % %     X1 = X0 + S;
% % %     lambda = eig(X1);
% % %     lambda = lambda(1);
% % %     if lambda < 0
% % %         X1 = X1 + 1.01*lambda*eye(30);
% % %         S = X1-X0;
% % %     end
% % %     G0 = G1;
% % %     s = vec(S);
% % %     err = norm(s);
% % %     if err<1e-22
% % %         break
% % %     end
% % %     fprintf('%f %d\n',err,k)
% % % end





  

 
    