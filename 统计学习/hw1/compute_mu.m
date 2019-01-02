function mu_k = compute_mu(weights, N_k)
load('data.mat');
mu_k = zeros(size(train,1)-1,10);
for i = 1:10
    indx = (weights(1,:)==i-1);
    if N_k(i) == 0
        continue;
    else
        mu_k(:,i) = sum(train(2:end,indx).*weights(2,indx),2);
        mu_k(:,i) = mu_k(:,i)/N_k(i);
    end
end
end