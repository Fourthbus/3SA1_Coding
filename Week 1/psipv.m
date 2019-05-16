function psixy = psipv(xc,yc,Gamma,x,y)
    %calcualate r^2
    rsq = (x - xc)^2 + (y - yc)^2;
    %calculate psi in catesian
    psixy = -Gamma / 4 / pi * log(rsq);
end