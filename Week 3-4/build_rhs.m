function rhsvec = build_rhs(xs,ys,alpha)
np = length(xs)-1;
psifs = zeros(np+1,1);

for i = 1:np-1
    psifs(i,1)   = ys(i)  *cos(alpha)- xs(i)  *sin(alpha);
    psifs(i+1,1) = ys(i+1)*cos(alpha)- xs(i+1)*sin(alpha);
    rhsvec(i,1) = psifs(i,1)-psifs(i+1,1);
end

rhsvec(np,1)=0;
rhsvec(np+1,1)=0;

end
