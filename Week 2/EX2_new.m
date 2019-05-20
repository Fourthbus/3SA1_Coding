clear
close all

%Re and du/dx
Re = 1e7;
duedx = -.2;

%set boundary conditions
n = 101;
laminar = true;
attached = true;
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
        disp([x(i) Rethet/1000]);
    end
end