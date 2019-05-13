function lhsmat = build_lhs(xs,ys)

    np = length(xs)-1
    psip = zeros (np,np+1)
    
    for j = 1:np+1;
        if j == 1;
            psip(i,j) = infa(i,j) 
        elseif j == np+1;
            psip(i,j) = infb(i,j-1)
        else
            psip = infa(i,j)+infb(i,j-1)
        end
    end
end

        