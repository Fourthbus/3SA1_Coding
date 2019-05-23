function lhsmat = build_lhs(xs,ys)
    %construct matrix
    np = length(xs)-1;
    psip = zeros (np,np+1);
    %filling up psip
    for i = 1:np;
        %psip when j=1
        [psip(i,1) infb(i,1)] = panelinf(xs(1),xs(2),ys(1),ys(2),xs(i),ys(i));
        %psip when j=np+1 i.e. =infb(j-1)=infb(np)
        [~,psip(i,np+1)] = panelinf(xs(np),xs(np+1),ys(np),ys(np+1),xs(i),ys(i));
        %psip for the rest
        for j = 2:np;
            [infa(i,j) infb(i,j)] = panelinf(xs(j),xs(j+1),ys(j),ys(j+1),xs(i),ys(i));
            psip(i,j) = infa(i,j) + infb(i,j-1);
        end
    end
    %construct LHS matrix
    lhsmat = zeros(np+1);
    %loop around nodes 1->np-1 as 1->2=0, 2->3=0... np-1->np=0 row will be
    %rows: eliminated by summing up 1->np-1 instead (i.e. only np-1 equations)
    for i = 1:np-1;
        %colmns: contribution of jth panel 1->np+1
        for j = 1:np+1;
            lhsmat(i,j) = psip(i+1,j)-psip(i,j);
        end
    end
    %cutta condition: gamma_1 and gamma_np+1=0 so these two allow two rows
    %specifing these conditions i.e 1st or np+1th term=1, rest=0. N.B.
    %rhs's Kutta matches this accrodingly
    lhsmat(np,1) = 1;
    lhsmat(np,2) = -1;
    lhsmat(np,3) = 0.5;
    lhsmat(np,np) = -0.5;
    lhsmat(np,np+1) = 1;
    lhsmat(np+1,2) = 1;
    lhsmat(np+1,3) = -0.5;
    lhsmat(np+1,np-1) = 0.5;
    lhsmat(np+1,np) = 1;
    lhsmat(np+1,np+1) = 1;
end

        