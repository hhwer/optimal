function ret = TCC(X, Y)
    [~, ~, R] = canoncorr(X, Y);
    ret = sum(R);
end