clear
close all

%Discretisation of x
x = linspace(0,1,101);

%Re and du/dx
ReL = 1e3;
dudx = -.5;

%initialision matrices storing transitiona and separation locations
int = 0;
ils = 0;

%Imposing the initial condition where flow is laminar
%Reset laminar flag
laminar = true;

%Imposing the initial condition that flow is attached
%Reset separation flag
separation = false;

for i = 1:length(x);
    ue(i) = dudx*x(i)+1;

    %Iterate for theta, Rethet, m, H, and He for various x positions
    theta(i) = sqrt(.45/ReL*(ue(i))^-6*ueintbit(0,ue(1),x(i),ue(i)));
    Rethet(i) = theta(i)*ReL*(ue(i));
    m(i) = -ReL*(theta(i))^2*dudx;
    H(i) = thwaites_lookup(m(i));
    He(i) = laminar_He(H(i));

    %Check for transition
    if laminar == true;
        if log(Rethet(i)) >= 18.4*He(i) - 21.74;
            %If above condition is true, flow is no longer laminar
            laminar = false;
            int = x(i);
        end
    end

    %Check for Separation
    if separation == false;
        if m(i) >= 0.09;
            %If above is true, separation has occured.
            separation = true;
            ils = x(i);
        end
    end
end