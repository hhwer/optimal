function Sigma = compute_Sigma(weights, mu_k, N)
load('data.mat');
Sigma = zeros(size(train,1)-1);
for i = 1:10
    indx = train(1,:)==i-1;
    train_k = train(2:end,indx)-mu_k(:,i);
    Sigma = Sigma + train_k*train_k'*weights(2,i);
end
Sigma = Sigma/N;
end