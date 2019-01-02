function [N_k, N] = compute_N(weights)
N_k = zeros(1,10);
for i = 1:10
    N_k(i) = sum(weights(2,weights(1,:)==i-1));
end
N = sum(N_k);
end