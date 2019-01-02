function W =  GS(W,R)
    [d,k]=size(W);
    for j = 1:k
        C = zeros(d,j-1);
        for jj = 1:j-1
            C(:,jj) = W(:,jj)*(W(:,j)'*R*W(:,jj))/(W(:,jj)'*R*W(:,jj));
        end
        W(:,j)=W(:,j)-sum(C,2);
        % W(:,j)=W(:,j)/normR(W(:,j),R);
        W(:,j)=W(:,j) / (W(:,j)'*R*W(:,j))^0.5;
    end
end

function y = normR(x,R)
    y = sqrt(x'*R*x);
end 