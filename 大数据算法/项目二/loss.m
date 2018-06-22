function [ f ] = loss( a,b,x )
f = mean(log(1+exp(-x'*a.*b')));
end

