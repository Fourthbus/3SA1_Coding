clear
close all

%Constants
xmin = -2.5;
xmax = 2.5;
ymin = -2;
ymax = 2;
del = 1.5;
xc = .75;
yc = 0.5;

%Discretisation steps
nx = 51;
ny = 41;
%Gamma = 3.0;
nv = 100;


%Solving for exact values of infa and infb
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
title('Contour of exact value of infa')

figure(2)
contour(xm,ym,infb,c)
title('Contour of exact value of infb')

%finding values for f_a by setting gamma_b=0
gammaa = 1;
gammab = 0;
nv = 100;

for i =  1:nv;
    for j = 1:ny;
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nv-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
        for k = 1:nv;
            Gamma(k) = (2*gammaa+(gammab-gammaa)/nv*(2*k-1))*del/nv/2;
            xc(k) = (del/nv*(k-.5));
            yc(k) = 0;
            psik(k)=psipv(xc(k),yc(k),Gamma(k),xm(i,j),ym(i,j));
        end
        infa_est(i,j) = sum(psik);
    end
end
figure(3)
contour(xm,ym,infa_est,c)
title('Contour of estimated value of infa')

%Solving for estimated value of inbf by assuming gamma_a=0
gammaa = 0;
gammab = 1;

for i =  1:nv;
    for j = 1:ny;
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nv-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
        %loop for every single discretised vortex on sheet
        for k = 1:nv;
            Gamma(k) = (2*gammaa+(gammab-gammaa)/nv*(2*k-1))*del/nv/2;
            xc(k) = (del/nv*(k-.5));
            yc(k) = 0;
            psik(k)=psipv(xc(k),yc(k),Gamma(k),xm(i,j),ym(i,j));
        end
        %sum up every vortex
        infb_est(i,j) = sum(psik);
    end
end
figure(4)
contour(xm,ym,infb_est,c)
title('Contour of exact value of infb')