clear
close all

%Constants
xmin = -2.5;
xmax = 2.5;
ymin = -2;
ymax = 2;

%Discretisation Steps
nx = 51;
ny = 41;
np = 100;

%Declaration of theta
theta = (0:np)*2*pi/np;

%Iteration for positions and circulation on sphere
for i = 1:np+1;
    xs(i) = cos(theta(i));
    ys(i) = sin (theta (i));
    gamma(i) = -2*sin(theta(i));
end

%Iteration for stream functions 
for i =  1:nx;
    for j = 1:ny;
        xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
        ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
        %Uniform flow stream function
        psi(i,j) = ym (i,j);
        %Iterate for infa and infb using panelinf
        for k = 1:np;
            [infa(i,j,k) infb(i,j,k)] = panelinf(xs(k),xs(k+1),ys(k),ys(k+1),xm(i,j),ym(i,j));
            %Sum of uniform flow, gamma_a*infa, and gamma_b*infb
            psi(i,j) = psi (i,j) + gamma(k)*infa(i,j,k) + gamma(k+1)*infb(i,j,k);
        end
    end
end

c = -1.75:0.25:1.75;
contour(xm,ym,psi,c)
title('Cylinder Flow Streamlines')
hold on
plot (xs,ys)
hold off
    