[l,d] = correctCholesky(G, 2, 0.1);
E = G - l*diag(d)*l'