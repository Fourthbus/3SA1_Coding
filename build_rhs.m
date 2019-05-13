function rhsvec = build_rhs(xs,ys,alpha);
    np = length(xs)-1;
    psifs = zeros(1,np+1);
    for i=1:np+1;
        psifs(i) = ys(i)*cos(alpha)-xs(i)*sin(alpha);
    end
    rhsvec = zeros(np+1);
    for i=1:np+1;
        if i == 1;
            rhsvec(i) = 0;
        elseif i == np+1;
            rhsvec(i) = 0;
        else
            rhsvec(i) = psifs(i) - psifs(i+1);
        end
    end
end
    