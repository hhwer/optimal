function [fun] = func(x,S)
fun = -log(det(x)) + trace(S*x);
end