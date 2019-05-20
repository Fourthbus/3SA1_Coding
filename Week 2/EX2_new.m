clear
close all
%input conditions
Re = 1e6;
duedx = -.5;
%iteration setting & initial conditions
n = 101;
laminar = true;
x = linspace(0,1,n);
ue0 = 1;
%initialsing transition and seperation pointer
int = 0;
ils = 0;
%generating ue matrix
for i = 1:n;
    ue(i) = duedx*x(i)+ue0;
end
i=1;    %initialising loop
while laminar && i < n; %laminar loop
    i = i+1;    %interpretation
    theta(i) = sqrt(.45/Re*(ue(i))^-6*ueintbit(0,ue(1),x(i),ue(i)));
    Rethet = theta(i)*Re*(ue(i));
    m = -Re*(theta(i))^2*duedx;
    H = thwaites_lookup(m);
    He(i) = laminar_He(H);
    if log(Rethet) >= 18.4*He(i) - 21.74;   %laminar check
        laminar = false;    %laminar flag & end loop
        int = i;
        display([x(i), Rethet/1000]);
    end
end