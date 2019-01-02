function cos_theta = calc_cos(W, V, B)
    W = GS(W,B);
    V = GS(V,B);
    cos_theta = min(svd(V'*B*W));
end