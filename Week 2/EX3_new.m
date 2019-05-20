clear
close all

%Re and du/dx
Re = 1e6;
duedx = -.5;

%set boundary conditions
n = 101;
laminar = true;
x = linspace(0,1,n);

%initialision matrices storing transitiona and separation locations
int = 0;
ils = 0;

%generating ue
for i = 1:n;
    ue(i) = duedx*x(i)+1;
end

%transition loop
i = 1;

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




while laminar && i < n;
    i = i+1;
    theta = sqrt(.45/Re*(ue(i))^-6*ueintbit(0,ue(1),x(i),ue(i)));
    Rethet = theta*Re*(ue(i));
    m = -Re*(theta)^2*duedx;
    H = thwaites_lookup(m);
    He = laminar_He(H);

    if log(Rethet) >= 18.4*He - 21.74;
        %If above condition is true, flow is no longer laminar
        laminar = false;
        int = i;
    end
end

if int ~= 0;
    disp(['Natural transition at ' num2str(x(int)) ' with Rethet ' num2str(Rethet)]);
end

%seperation loop
while attached && i < n;
    i = i+1;
    theta = sqrt(.45/Re*(ue(i))^-6*ueintbit(0,ue(1),x(i),ue(i)));
    Rethet = theta*Re*(ue(i));
    m = -Re*(theta)^2*duedx;

    if m >= 0.09;
        %If above condition is true, flow is no longer laminar
        attached = false;
        ils = i;
    end
end

if int ~= 0;
    disp(['Seperation at ' num2str(x(ils)) ' with Rethet ' num2str(Rethet)]);
end
