clear
close all
%input x
x = linspace(0,1,101);

%input variables for Re's du/dx=-0.2
ReL = [1e6 1e7 1e8];
grad = [-.2 0 .2];

for k = 1:length(grad);
    %iterate a matrix for ue
    for i = 1:length(x);
        ue(i,k) = grad(k)*x(i)+1;
    end

    %iterate for theta/L
    for i=1:length(x);
        for j=1:3;
            theta(j,k,i) = sqrt(.45/ReL(j)*(ue(i,k))^-6*ueintbit(0,ue(1,k),x(i),ue(i,k)));
            ReT(j,k,i)=theta(j,k,i)*ReL(j)*(ue(i,k));
            m(j,k,i)=-ReL(j)*(theta(j,k,i))^2*grad(k);
        end
    end
end