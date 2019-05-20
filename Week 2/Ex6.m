clear
close all

%Defining global variables value
global Re ue0 duedx

%Re and du/dx
Re = 1e6;
ue0 = 1;
duedx = -1;

%set boundary conditions
n = 101;
laminar = true;
x = linspace(0,1,n);

%initialision matrices storing transitiona and separation locations
int = 0;
ils = 0;
itr = 0;
its = 0;

%generating ue
for i = 1:n;
    ue(i) = duedx*x(i)+ue0;
end

%laminar loop
i = 1;
while laminar && i < n;
    i = i+1;
    theta(i) = sqrt(.45/Re*(ue(i))^-6*ueintbit(0,ue(1),x(i),ue(i)));
    Rethet = theta(i)*Re*(ue(i));
    m = -Re*(theta(i))^2*duedx;
    H = thwaites_lookup(m);
    He(i) = laminar_He(H);
    if log(Rethet) >= 18.4*He(i) - 21.74;
        %If above condition is true, flow is no longer laminar
        laminar = false;
        int = i;
    elseif m >= 0.09;
        %If above condition is true, flow is no longer laminar
        laminar = false;
        ils = i;
        He(i) = 1.51509;    %set He to seperated value
    end
end
%boubndary value for He
He(1) = 1.57258;
%calculate deltaE value
deltaE = He.*theta;

%turbulent loop
while its == 0 && i < n;
    thick0(1) = theta(i);
    thick0(2) = deltaE(i);
    i = i+1;
    [delx thickhist] = ode45(@thickdash,[0,x(i)-x(i-1)],thick0);
    theta(i) = thickhist(length(delx),1);
    deltaE(i) = thickhist(length(delx),2);
    He(i) = deltaE(i)/theta(i);
    %calculate H value (from thickdash alogorithm)
    if He(i) >= 1.46;
        H = (11*He(i)+15) / (48*He(i)-59);
    else
        H = 2.803;
    end
    %loop for turbulent reattachment
    if ils ~= 0 && He(i) >= 1.58 && itr == 0;
        itr = i;
    end
    %loop for turbulent seperation
    if He(i) <= 1.46;
        its = i;
    end
end

%final loop
while i < n;
    theta(i+1) = theta(i)*(ue(i)/ue(i+1))^(H+2);
    i = i+1;
    He(i) = He (its);
end

plot(x,He);