function rhsvec = build_rhs(xs,ys,alpha);

    np = length(xs)-1;
    psifs = zeros(1,np+1);
    rhsvec = zeros(np+1);
    
    for i = 1:np+1
        psifs(i) = ys(i)*cos(alpha) - xs(i)*sin(alpha);
    end
    
    for k = 1:np
        rhsvec (k) = psifs(k) - psifs(k+1);
    end
    
    %imposing Kutta Condition
    rhsvec(1) = 0;
    rhsvec(np+1) = 0
    
end
    