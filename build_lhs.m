function lhsmat = build_lhs(xs,ys)
    np = length(xs)-1;
    psip = zeros (np,np+1);
    
    for i = 1:np;
        [psip(i,j=1) infb(i,j=1)] = panelinf(xs(1),xs(2),ys(1),ys(2),xs(i),ys(i);
        [~ psip(i,j=np+1)] = panelinf(xs(np),xs(np+1),ys(np),ys(np+1),xs(i),ys(i);
        for j = 2:np;
            [infa(i,j) infb(i,j)] = panelinf(xs(j),xs(j+1),ys(j),ys(j+1),xs(i),ys(i);
            psip(i,j) = infa(i,j) + infb(i,j-1);
        end
    end
    lhsmat = zeros(np+1,np+1);
    for i = 2:np;
        for j = 1:np+1;
            lhsmat(i,j) = psip(i+1,j)-psip(i,j);
        end
    end
    %cutta condition gamma_1 and gamma_np+1=0 so...
    lhsmat(1,1) = 1;
    lhsmat(np+1,np+1) =1;
end

        