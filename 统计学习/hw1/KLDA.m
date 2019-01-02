clear;clc;
global train;
global test;
load data.mat;
% 40往上没意义
k = kernel(1,40);
tic;
is_correct = zeros(1,size(test,2));
for i = 1:size(test, 2)
    weights = zeros(2, size(train, 2));
    weights(1, :) = train(1,:);
    weights(2, :) = k(test(2:end,i), train(2:end,:));
    [N_k, N] = compute_N(weights);
    mu_k = compute_mu(weights, N_k);
    Sigma = compute_Sigma(weights, mu_k, N);
    pi_k = N_k/N;
    [result,y] = lda(test(2:end,i), Sigma, mu_k, pi_k);
    is_correct(i) = (result==test(1,i));
end
toc;
corr_rate = sum(is_correct)/size(test,2);
disp(corr_rate);
% plot_result(is_correct);