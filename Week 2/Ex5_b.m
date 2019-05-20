clear
close all

%Defining global variables value
global Re ue0 duedx

Re = 1e6;
ue0 = 1;
duedx = -.6;

%Initial values of theta and delta_E
x0 = 0.01;
thick0(1) = 0.037*x0*(Re*x0)^(-1/5);
thick0(2) = 1.80 * thick0(1);

[delx thickhist] = ode45(@thickdash,[0 0.99],thick0);

%calculate He
for i = 1:length(delx);
    He(i) = thickhist(i,2)/thickhist(i,1);
end

figure(1);
hold on
%plot reference value
plot([0 1],[1.46 1.46],'--');
%plot He
plot(delx+x0,He);
xlabel('non dimensional position x/L');
ylabel('Energy shape factor H_E');
title('Plot under d(u_e/U)/d(x/L) = -0.6');

%plot theta and deltaE
figure(2);
hold on
plot(delx+x0,thickhist(:,1));
plot(delx+x0,thickhist(:,2));
xlabel('non dimensional position x/L');
ylabel('non dimensional thickness');
legend('\theta','\delta_E','location','Northwest');
title('Plot under Re=10^6 d(u_e/U)/d(x/L) = -0.6');
saveas(gcf,'EX5_2_2.pdf');
hold off

%plotting duedx = -.6
clear He
Re = 1e7;
[delx thickhist] = ode45(@thickdash,[0 0.99],thick0);
for i = 1:length(delx);
    He(i) = thickhist(i,2)/thickhist(i,1);
end
%plot He
figure(1)
plot(delx+x0,He);

%plot theta and deltaE
figure(3);
hold on
plot(delx+x0,thickhist(:,1));
plot(delx+x0,thickhist(:,2));
xlabel('non dimensional position x/L');
ylabel('non dimensional thickness');
legend('\theta','\delta_E','location','Northwest');
title('Plot under Re=10^7 d(u_e/U)/d(x/L) = -0.6');
saveas(gcf,'EX5_2_3.pdf');
hold off

%plotting duedx = -.9
clear He
Re = 1e8;
[delx thickhist] = ode45(@thickdash,[0 0.99],thick0);
for i = 1:length(delx);
    He(i) = thickhist(i,2)/thickhist(i,1);
end
%plot He
figure(1);
plot(delx+x0,He);
legend('H_E = 1.46 Seperation condition','Re = 10^6','Re = 10^7','Re = 10^8','location','Southwest');
saveas(gcf,'EX5_2_1.pdf')

%plot theta and deltaE
figure(4);
hold on
plot(delx+x0,thickhist(:,1));
plot(delx+x0,thickhist(:,2));
xlabel('non dimensional position x/L');
ylabel('non dimensional thickness');
legend('\theta','\delta_E','location','Northwest');
title('Plot under Re=10^8 d(u_e/U)/d(x/L) = -0.6');
saveas(gcf,'EX5_2_4.pdf');
hold off

hold off
