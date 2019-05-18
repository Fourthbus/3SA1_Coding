function dthickdx = thickdash(xmx0,thick);
    %import global variables
    global Re ue0 duedx
    %find theta and deltaE as defined
    theta = thick(1);
    deltaE = thick(2);
    %calculate He
    He = deltaE/theta;
    %calculate H
    if He >= 1.46;
        H = (11*He+15) / (48*He-59);
    else
        H = 2.803;
    end
    %calculate ue
    ue = ue0 + duedx * xmx0;
    %calculate Re_theta
    Rethet = Re * ue * theta;
    %calculate cf
    cf = 0.091448*((H-1)*Rethet)^(-.232)*exp(-1.260*H);
    %calculate cdiss
    cdiss = 