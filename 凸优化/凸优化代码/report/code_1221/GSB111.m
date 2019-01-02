function W =  GSB111(W,B)
    [d,k] = size(W);
    
    for j = 1:k
        C = zeros(d,j-1);
        for jj = 1:j-1
            C(:,jj) = W(:,jj)*(W(:,j)'*B*W(:,jj));
        end
        W(:,j)=W(:,j)-sum(C,2);
    W(:,j)=W(:,j)/(W(:,j)'*B*W(:,j))^0.5;
    end
end