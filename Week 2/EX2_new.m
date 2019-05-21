clear
close all

%Input Conditions, change according to required by Exercise
Re = 1e6;
duedx = -.2;

%Initial Conditions and Discretisation steps
n = 101;
laminar = true;
x = linspace(0,1,n);
ue0 = 1;

%Initialise transition and separation indicators
int = 0;
ils = 0;

%Generate a matrix of ue values
for i = 1:n;
    ue(i) = duedx*x(i)+ue0;
end

%To initialise loop
i = 1;
while laminar && i < n; %laminar loop
    i = i+1;    %Increase interation counter
    
    %Solve for theta, Rethet, m, H, He
    theta(i) = sqrt(.45/Re*(ue(i))^-6*ueintbit(0,ue(1),x(i),ue(i)));
    Rethet = theta(i)*Re*(ue(i));
    m = -Re*(theta(i))^2*duedx;
    H = thwaites_lookup(m);
    He(i) = laminar_He(H);
    
    %Check for transition
    if log(Rethet) >= 18.4*He(i) - 21.74;  %Transition condition
        laminar = false;    %Flow no longer laminar 
        int = i;    %Save iteration at transition occurs
        display([x(i), Rethet/1000]);
    end
end