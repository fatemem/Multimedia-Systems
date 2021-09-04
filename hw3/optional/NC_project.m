function NC=NC_project(S, W1D)
m=0;
n=length(S);
for i=1:n
    e=(S(i)-W1D(i))^2;
    m=m+e;
end
MSE=m/n;
NC=1-MSE;
end