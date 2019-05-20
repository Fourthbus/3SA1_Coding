function f = ueintbit(xa,ua,xb,ub)

    %Calculate for variables
    ubar = (ua+ub)/2;
    du = ub-ua;
    dx = xb-xa;
    
    %Solve for integral
    f = (ubar^5 + 5/6*ubar^3*(du)^2 + 1/16*ubar*(du)^4)*dx;
end