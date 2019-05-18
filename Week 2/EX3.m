clear
close all
%input x
x = linspace(0,1,101);

%input variables for Re's du/dx's
ReL = [1e3 1e4 1e5];
grad = [-.5];

%initialision matrices storing transitiona and seperation locations
int = 0;
ils = 0;

%iterate for different du/dx's
for k = 1:length(grad);
    %iterate a matrix for ue
    for i = 1:length(x);
        ue(i,k) = grad(k)*x(i)+1;
    end
    %iterate for theta/L
    for j=1:length(ReL);
        %reset laminar flag
        laminar = true;
        %reset seperation flag
        seperation = false;
        %iterate for all x
        for i=1:length(x);
            theta(j,k,i) = sqrt(.45/ReL(j)*(ue(i,k))^-6*ueintbit(0,ue(1,k),x(i),ue(i,k)));
            Rethet(j,k,i) = theta(j,k,i)*ReL(j)*(ue(i,k));
            m(j,k,i) = -ReL(j)*(theta(j,k,i))^2*grad(k);
            H(j,k,i) = thwaites_lookup(m(j,k,i));
            He(j,k,i) = laminar_He(H(j,k,i));
            %here when laminar flag is false 
            if laminar == true;
                if log(Rethet(j,k,i)) >= 18.4*He(j,k,i) - 21.74;
                    laminar = false;
                    int(j,k) = x(i);
                end
            end
            %record sepetation location
            if seperation == false;
                if m(j,k,i) >= 0.09;
                    seperation = true;
                    ils(j,k) = x(i);
                end
            end
        end
    end
end