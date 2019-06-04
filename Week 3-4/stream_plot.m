function [xm,ym,psi,c] = stream_plot(xs,ys,gam,alfrad);
    %Constants
    xmin = -.25;
    xmax = 1.25;
    ymin = -.25;
    ymax = .25;

    %Discretisation Steps
    nx = length(xmin:0.025:xmax);
    ny = length(ymin:0.025:ymax);
    %np = 100;
    np = length(xs)-1;

    %Iteration for stream functions 
    psi = zeros(nx,ny); xm = zeros(nx,ny); ym = zeros(nx,ny);
    for i =  1:nx;
        for j = 1:ny;
            xm(i,j) = xmin + (i-1)*(xmax-xmin)/(nx-1);
            ym(i,j) = ymin + (j-1)*(ymax-ymin)/(ny-1);
            %Uniform flow stream function
            psi(i,j) = ym(i,j)*cos(alfrad) - xm(i,j)*sin(alfrad);
            %Iterate for infa and infb using panelinf
            for k = 1:np;
                [infa(i,j,k) infb(i,j,k)] = panelinf(xs(k),xs(k+1),ys(k),ys(k+1),xm(i,j),ym(i,j));
                %Sum of uniform flow, gamma_a*infa, and gamma_b*infb
                psi(i,j) = psi (i,j) + gam(k)*infa(i,j,k) + gam(k+1)*infb(i,j,k);
            end
        end
    end
    c = psi(51,11)-1.5:.02:psi(51,11)+1.5;
end