function [infa infb] = refpaninf(del,X,Yin);
    %correct Y's zero error
    if abs(Yin) < 1e-19
        Y = 1e-19;
    else
        Y = Yin;
    end
    %calculate I0 and I1
    I0 = -1/4/pi*(X*log(X^2+Y^2)-(X-del)*log((X-del)^2+Y^2)-2*del+2*Y*(atan(X/Y)-atan((X-del)/Y)));
    I1 = 1/8/pi*((X^2+Y^2)*log(X^2+Y^2)-((X-del)^2+Y^2)*log((X-del)^2+Y^2)-2*X*del+del^2);
    %calculate infa and infb by formulae given
    infa = (1-(X/del))*I0 - I1/del;
    infb = X/del*I0 + I1/del;
end