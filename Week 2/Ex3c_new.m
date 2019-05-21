clear
close all

%Input Conditions, change according to required by Exercise
Re = linspace(1e6,1e7,9001);
duedx = -.5;

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
i=1; 
    while i < n; %laminar loop
        i = i+1;    %Increase interation counter
        
        for k = 1:length(Re);
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
            
        if int ~= 0 && int < ils;
            disp(['Natural transition at ' num2str(Re(k))])
            break
    end
    end
end

%if int ~= 0;
 %   disp(['Natural transition at ' num2str(x(int)) ' with Rethet ' num2str(Rethet)]);
%elseif ils ~= 0;
 %   disp(['Laminar seperation at ' num2str(x(ils)) ' with Rethet ' num2str(Rethet)]);
%end
