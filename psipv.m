function psixy = psipv(xc,yc,Gamma,x,y)
    rsq = (x - xc)^2 + (y - yc)^2;
    psixy = -Gamma / 4 / pi * log(rsq);
end