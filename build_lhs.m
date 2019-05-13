function lhsmat = build_lhs(xs,ys)
    np = length(xs)-1;
    psip = zeros (np,np+1);
    
    for j = 1:np+1;
        for i = 1:np+1;
            if j < np+1;
                [infa(i,j) infb(i,j)] = panelinf(xs(j),xs(j+1),ys(j),ys(j+1),xs(i),ys(i));
            else
            end
            if j == 1;
                psip(i,j) = infa(i,j);
            elseif j == np+1;
                psip(i,j) = infb(i,j-1);
            else
                psip(i,j) = infa(i,j)+infb(i,j-1);
            end
        end
    end
    lhsmat = zeros(np+1,np+1);
    for i = 1:np+1;
        for j = 1:np+1;
            if i == 1;
                lhsmat(i,j)=0;
            elseif i == np+1;
                lhsmat(i,j)=0;
            else
                lhsmat(i,j) = psip(i+1,j)-psip(i,j);
            end
        end
    end
end

        