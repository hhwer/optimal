function [Wx,Wy] = CCALin(X, Y, T, k)
[n,d1] = size(X);
[~,d2] = size(Y);
SXX = X'*X/n;  %d1*d1
SYY = Y'*Y/n;  %d2*d2
SXY = X'*Y/n;  %d1*d2
A = [zeros(d1),SXY;SXY',zeros(d2)]; 
B = [SXX,zeros(d1,d2);zeros(d2,d1),SYY];
W = GenELinK(A,B,T,2*k);disp('done');
Wx = W(1:d1,:);
Wy = W(d1+1:d1+d2,:);
U = normrnd(0,1,2*k,k);
Wx = Wx*U;
Wy = Wy*U;
Wx = GS(Wx,SXX);
Wy = GS(Wy,SYY);
function W =  GS(W,R)
    [d,~]=size(W);
    for j = 1:k
        C = zeros(d,j-1);
        for jj = 1:j-1
            C(:,jj) = W(:,jj)*(W(:,j)'*R*W(:,jj))/(W(:,jj)'*R*W(:,jj));
        end
        W(:,j)=W(:,j)-sum(C,2);
        W(:,j)=W(:,j)/normR(W(:,j),R);
    end
end
function y = normR(x,R)
    y = sqrt(x'*R*x);
end 
end