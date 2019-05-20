clear
close all

%Constants
xmin = 0;
xmax = 5;
ymin = 0;
ymax = 4;

%Discretisation Steps
nx = 51;
ny = 41;
nv = 100;

%Vector Points
xa = 4.1;
ya = 1.3;
xb = 2.2;
yb = 2.9;

%Exact solution of infa and infb
for i =  1:nx;
    for j = 1:ny;
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
        [infa(i,j) infb(i,j)] = panelinf(xa,xb,ya,yb,xm(i,j),ym(i,j));
    end
end

figure(1);
c = -.15:.05:.15;
contour(xm,ym,infa,c);
title('Contour of exact value of infa')

figure(2);
contour(xm,ym,infb,c);
title('Contour of exact value of infb')

%Estimated solution for infa
gammaa = 1;
gammab = 0;
del = norm([xb-xa yb-ya]);
for i =  1:nv;
    for j = 1:ny;
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nv-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
        %loop for every single discretised vortex on sheet
        for k = 1:nv;
            Gamma(k) = (2*gammaa+(gammab-gammaa)/nv*(2*k-1))*del/nv/2;
            xc(k) = xa + (xb-xa)/nv*(k-.5);
            yc(k) = ya + (yb-ya)/nv*(k-.5);
            psik(k)=psipv(xc(k),yc(k),Gamma(k),xm(i,j),ym(i,j));
        end
        %sum up every vortex
        infb_est(i,j) = sum(psik);
    end
end

figure(3)
contour(xm,ym,infb_est,c)
title('Contour of estimated value of infa')

%Estimated solution for infb
gammaa = 0;
gammab = 1;
del = norm([xb-xa yb-ya]);
for i =  1:nv;
    for j = 1:ny;
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nv-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
        %loop for every single discretised vortex on sheet
        for k = 1:nv;
            Gamma(k) = (2*gammaa+(gammab-gammaa)/nv*(2*k-1))*del/nv/2;
            xc(k) = xa + (xb-xa)/nv*(k-.5);
            yc(k) = ya + (yb-ya)/nv*(k-.5);
            psik(k)=psipv(xc(k),yc(k),Gamma(k),xm(i,j),ym(i,j));
        end
        %sum up every vortex
        infb_est(i,j) = sum(psik);
    end
end

figure(4)
contour(xm,ym,infb_est,c)
title('Contour of estimated value of infb')
