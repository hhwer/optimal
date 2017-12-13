f = @(x)x*(x-pi)*(x-2*pi);
g = @(x)3*x^2-6*pi*x+2*pi^2;
N  = 2^8;
x = zeros(2*N,1);
for j = 0:2*N-1
    x(j+1) = j*pi/N;
end
F = zeros(2*N,1);
G = zeros(2*N,1);
for j = 0:2*N-1
    F(j+1) = f(x(j+1));
    G(j+1) = g(x(j+1));
end
% for j = 0:2*N-1
%     F(j+1) = (-1)^j*F(j+1);
% end
F1 = fft(F);
% p = -N:N-1;
% p = ones(2*N,1);
p = [0:N-1,-N:-1];
for j = 0:2*N-1
%     F1(j+1) = 1j*(-1)^j*p(j+1)*F1(j+1);
    F1(j+1) = 1j*p(j+1)*F1(j+1);
end
F2 = ifft(F1);
% for j = 0:2*N-1
%     F2(j+1) = (-1)^j*F2(j+1);
% end
F2(:,2) = G;
% F1(:,2)
