clear
close all

%Defining global variables value
global Re ue0 duedx

Re = 1e7;
ue0 = 1;
duedx = -.3;

%Initial values of theta and delta_E
x0 = 0.01;
thick0(1) = 0.037*x0*(Re*x0)^(-1/5);
thick0(2) = 1.80 * thick0(1);

[delx thickhist] = ode45(@thickdash,[0 0.99],thick0);

%calculate He
for i = 1:length(delx);
    He(i) = thickhist(i,2)/thickhist(i,1);
end

hold on
plot([0 1],[1.46 1.46],'--');
plot(delx+x0,He);
xlabel('non dimensional position x/L');
ylabel('Energy shape factor H_E');

%plotting duedx = -.6
clear He
duedx = -.6;
[delx thickhist] = ode45(@thickdash,[0 0.99],thick0);
for i = 1:length(delx);
    He(i) = thickhist(i,2)/thickhist(i,1);
end
plot(delx+x0,He);

%plotting duedx = -.9
clear He
duedx = -.9;
[delx thickhist] = ode45(@thickdash,[0 0.99],thick0);
for i = 1:length(delx);
    He(i) = thickhist(i,2)/thickhist(i,1);
end
plot(delx+x0,He);

legend('H_E = 1.46 Seperation condition','d(u_e/U)/d(x/L) = -0.3','d(u_e/U)/d(x/L) = -0.6','d(u_e/U)/d(x/L) = -0.9','location','Southwest');
hold off
%save pdf
saveas(gcf,'EX5_1.pdf')

%plot theta and deltaE