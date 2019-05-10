function [infa infb] = refpaninf(del,X,Yin)
    if abs(Yin) < 1e-19
        Y = 1e-19;
    else
        Y = Yin;
    end
    I0 = -(X*log(X^2+Y^2) - (X-del)*log((X-del)^2+Y^2) - 2*del + 2*Y*(atan(X/Y) - atan ((X-del)/Y)))/4/pi;
    I1 = ((X^2+Y^2)*log(X^2+Y^2) - ((X-del)^2+Y^2)*log((X-del)^2+Y^2) - 2*X*del + del^2)/8/pi;
    
    infa = (1-(X/del))*I0 - I1/del;
    infb = X/del*I0 + I1*del;
end