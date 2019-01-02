function [z] = F(Q,A,b,c,t,z)
    u =  z;
    u(u<0) = 0;
    z = 2*u-z;
    z = z-t*c-A'*(Q*(A*z-b-t*A*c));
    z = u-z;
end