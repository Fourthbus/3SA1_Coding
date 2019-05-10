clear
close all

xmin = -2.5;
xmax = 2.5;
nx = 51;
xc = 0.75;
ymin = -2;
ymax = 2;
ny = 41;
yc = 0.5;
Gamma = 3.0;

for i = 1:nx;
    for j = 1:ny;
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
        psi(i,j) = psipv(xc,yc,Gamma,xm(i,j),ym(i,j));
    end
end

c = -.4:.2:1.2;
figure(1);
contour(xm,ym,psi,c);
