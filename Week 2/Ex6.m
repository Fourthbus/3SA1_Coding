clear
close all

%Defining global variables value
global Re ue0 duedx

%Re and du/dx
Re = 1e3;
duedx = -.5;

%boundary conditions
x0 = 0.01;
thick0(1) = 0.037*x0*(Re*x0)^(-1/5);
thick0(2) = 1.80 * thick0(1);

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
    ue(i) = duedx*x(i)+1;

    %Iterate for theta, Rethet, m, H, and He for various x positions
    theta(i) = sqrt(.45/Re*(ue(i))^-6*ueintbit(0,ue(1),x(i),ue(i)));
    Rethet(i) = theta(i)*Re*(ue(i));
    m(i) = -Re*(theta(i))^2*duedx;
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