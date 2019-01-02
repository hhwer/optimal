function [result, y] = lda(x, Sigma, mu_k, pi_k)
Sigma_inv_mu = (Sigma+1e-8*eye(size(Sigma)))\mu_k;
y = x'*(Sigma_inv_mu)-0.5*diag(mu_k'*Sigma_inv_mu)'+log(pi_k);
G = 0:9;
result = G(y==max(y)); 
end