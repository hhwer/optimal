function ret = PCC(X, Y, Wx, Wy, Vx, Vy)
    ret = TCC(X*Wx, Y*Wy)/TCC(X*Vx, Y*Vy);
end