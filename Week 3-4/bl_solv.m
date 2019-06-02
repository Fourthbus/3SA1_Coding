function [int ils itr its delstar theta] = bl_solv(x,cp);
%Defining global variables value
global Re ue0 duedx

ue = (1-cp).^.5; %convert cp to ue

%Iteration setting & initial conditions
n = length(x);
laminar = true;

%%initialsing indicators
int = 0;    %natural transition
ils = 0;    %laminar seperation
itr = 0;    %turbulent reattachment
its = 0;    %turbulent seperation
ueint = 0;  %integral of ueintbit

%initialising i
i = 0;
while laminar && i < n; %laminar loop
    i = i+1;    %interpretation
    if i == 1;
        duedx = ue(i)/x(i);  %calculate duedx
        ueint = ueint + ueintbit(0,0,x(i),ue(i));    %calculating ueint 0->x
    else
        duedx = (ue(i)-ue(i-1))/(x(i)-x(i-1));  %calculate duedx
        ueint = ueint + ueintbit(x(i-1),ue(i-1),x(i),ue(i));    %calculating ueint 0->x
    end
    theta(i) = sqrt(.45/Re*(ue(i))^-6*ueint);
    Rethet = theta(i)*Re*(ue(i));
    m = -Re*(theta(i))^2*duedx;
    H(i) = thwaites_lookup(m);
    He(i) = laminar_He(H(i));
    if log(Rethet) >= 18.4*He(i) - 21.74;   %laminar check
        laminar = false;    %laminar flag & end loop
        int = i;    %set pointer
        %disp(['Turbulent Transition at x/L = ' num2str(x(int)) ' at Re_L ' num2str(Re)]);
        
    elseif m >= 0.09;   %seperation check
        laminar = false;    %also end laminar loop & turbulent formula
        ils = i;
        He(i) = 1.51509;    %set He to seperated value
        %disp(['Laminar Separation at x/L = ' num2str(x(ils)) ' at Re_L ' num2str(Re)])
    end
end

%Value for He for Laminar Flow
He(1) = 1.57258;

%Calculate deltaE matrix
deltaE = He.*theta;

%Turbulent Loop
while its == 0 && i < n;
    thick0(1) = theta(i);   %y matrix, value at elemental plate's start
    thick0(2) = deltaE(i);
    ue0 = ue(i);    %declear ue0 used for odf45
    i = i+1;
    duedx=(ue(i)-ue(i-1))/(x(i)-x(i-1));
    [delx thickhist] = ode45(@thickdash,[0,x(i)-x(i-1)],thick0);
    theta(i) = thickhist(length(delx),1);   %assign value at elemental plate's end
    deltaE(i) = thickhist(length(delx),2);
    He(i) = deltaE(i)/theta(i);
    H(i) = (11*He(i)+15)/(48*He(i)-59); %calculate for H
    
    %Check for turbulent reattachment
    if ils > 0 && He(i) >= 1.58 && itr == 0;   
        itr = i;
        %disp(['Turbulent Reattachmemt at x/L = ' num2str(x(itr)) ' at Re_L ' num2str(Re)]);
    end
    
    %Check for turbulent separation
    if He(i) <= 1.46;   %turbulent seperation check
        its = i;
        H(i)=2.803;    %H at seperation
        %disp(['Turbulent Separation at x/L= ' num2str(x(its)) ' at Re_L ' num2str(Re)]);
    end
end

while i < n;    %final loop
    theta(i+1) = theta(i)*(ue(i)/ue(i+1))^(H(i)+2);    %theta for cf=0
    i = i+1;  %H assumed to remain constant since He is constant
    H(i) = H(its);
end

delstar = H.*theta;
end