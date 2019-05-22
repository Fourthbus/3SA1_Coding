clear
close all

%Input Conditions, change according to required by Exercise
Re = linspace(1e6,1e7,9001);
duedx = -.5;

%Initial Conditions and Discretisation steps
n = 101;
x = linspace(0,1,n);
ue0 = 1;

%Generate a matrix of ue values
for i = 1:n;
    ue(i) = duedx*x(i)+ue0;
end

%To initialise loop
for k = 1:length(Re);
    i=1;
    
    %Initialise indicators at the start of every loop
    int = 0;
    ils = 0;
    
    %Reset laminar flag at the start of every loop
    laminar = true;
    
    %Laminar loop
    while laminar && i < n; 
        i = i+1;    %Increase interation counter
        
        %Solve for theta, Rethet, m, H, He
        theta(i) = sqrt(.45/Re(k)*(ue(i))^-6*ueintbit(0,ue(1),x(i),ue(i)));
        Rethet = theta(i)*Re(k)*(ue(i));
        m = -Re(k)*(theta(i))^2*duedx;
        H = thwaites_lookup(m);
        He(i) = laminar_He(H);

            %Check for transition
            if log(Rethet) >= 18.4*He(i) - 21.74;   %Transition condition
                laminar = false;    %Flow no longer laminar
                int = i;    %Save iteration where transition occurs

            %Check for separation
            elseif m >= 0.09;   %Separation Condition
                laminar = false;    %Flow no longer laminar
                ils = i;    %Save iteration where transition occurs
            end
    end
    
    %Display Re at which transition will supplant laminar separation
    if int ~= 0; %If transition occurs before separation, ils = 0
        disp(['Re_L at which transition supplants laminar transion is ',num2str(Re(k))])
        break %break loop once required Re is found
    end
end


