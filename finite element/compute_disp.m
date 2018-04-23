function [U1,U2] = compute_disp(u)
N = sqrt(length(u)/2)-1;
U1 = reshape(u(1:(N+1)^2),N+1,N+1)';
U2 = reshape(u((N+1)^2+1:2*(N+1)^2),N+1,N+1)';
end