clear
close all

xmin = -2.5;
xmax = 2.5;
ymin = -2;
ymax = 2;
del = 1.5;
xc = .75;
yc = 0.5;
nx = 51;
ny = 41;
Gamma = 3.0;
nv = 100;

for i =  1:nx;
    for j = 1:ny;
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
        [infa(i,j) infb(i,j)]=refpaninf(del,xm(i,j),ym(i,j));
    end
end
c = -.15:.05:.15;
figure(1)
contour(xm,ym,infa,c)
figure(2)
contour(xm,ym,infb,c)

for i =  1:nv;
    for j = 1:ny;
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nv-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
        psi(i,j)=psipv(xc,yc,Gamma,xm(i,j),ym(i,j));
    end
end
c1 = -.4:.2:1.2;
figure(3)
contour(xm,ym,psi,c1)