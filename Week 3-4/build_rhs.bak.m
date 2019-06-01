function rhsvec = build_rhs(xs,ys,alpha);
    %determine size and construct matrix
    np = length(xs)-1;
    psifs = zeros(np+1,1);
    rhsvec = zeros(np,1);
    for i = 1:np+1
        psifs(i) = ys(i)*cos(alpha) - xs(i)*sin(alpha);
    end
    
    for k = 1:np-1
        rhsvec (k) = psifs(k) - psifs(k+1);
    end    
    %imposing Kutta Condition as specifying in lhs file
    rhsvec(np) = 0;
    rhsvec(np+1) = 0;
end 