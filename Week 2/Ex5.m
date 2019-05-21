clear
close all

%Defining global variables value
global Re ue0 duedx

Re = 1e7;
ue0 = 1;
duedx = -.3;

%Boundary values of theta and delta_E
x0 = 0.01;
thick0(1) = 0.037*x0*(Re*x0)^(-1/5);
thick0(2) = 1.80 * thick0(1);

[delx thickhist] = ode45(@thickdash,[0 0.99],thick0);

%Calculate He
for i = 1:length(delx);
    He(i) = thickhist(i,2)/thickhist(i,1);
end

figure(1);
hold on
%Plot reference value
plot([0 1],[1.46 1.46],'--');

%Plot He
plot(delx+x0,He);
xlabel('non dimensional position x/L');
ylabel('Energy shape factor H_E');
title(['Re_L=',num2str(Re)]);

%plot theta and deltaE
figure(2);
hold on
plot(delx+x0,thickhist(:,1));
plot(delx+x0,thickhist(:,2));
xlabel('non dimensional position x/L');
ylabel('non dimensional thickness');
legend('\theta','\delta_E','location','Northwest');
title(['Re_L=',num2str(Re),' d(u_e/U)/d(x/L)=',num2str(duedx)]);
saveas(gcf,'EX5_1_2.pdf');
hold off

%Plotting duedx = -.6
clear He
duedx = -.6;
[delx thickhist] = ode45(@thickdash,[0 0.99],thick0);
for i = 1:length(delx);
    He(i) = thickhist(i,2)/thickhist(i,1);
end

%Plot He
figure(1)
plot(delx+x0,He);

%Plot theta and deltaE
figure(3);
hold on
plot(delx+x0,thickhist(:,1));
plot(delx+x0,thickhist(:,2));
xlabel('non dimensional position x/L');
ylabel('non dimensional thickness');
legend('\theta','\delta_E','location','Northwest');
title(['Re_L=',num2str(Re),' d(u_e/U)/d(x/L)=',num2str(duedx)]);
saveas(gcf,'EX5_1_3.pdf');
hold off

%Plotting duedx = -.9
clear He
duedx = -.9;
[delx thickhist] = ode45(@thickdash,[0 0.99],thick0);
for i = 1:length(delx);
    He(i) = thickhist(i,2)/thickhist(i,1);
end

%Plot He
figure(1);
plot(delx+x0,He);
legend('H_E = 1.46 Separation condition','d(u_e/U)/d(x/L) = -0.3','d(u_e/U)/d(x/L) = -0.6','d(u_e/U)/d(x/L) = -0.9','location','Southwest');
saveas(gcf,'EX5_1_1.pdf')

%Plot theta and deltaE
figure(4);
hold on
plot(delx+x0,thickhist(:,1));
plot(delx+x0,thickhist(:,2));
xlabel('non dimensional position x/L');
ylabel('non dimensional thickness');
legend('\theta','\delta_E','location','Northwest');
title(['Re_L=',num2str(Re),' d(u_e/U)/d(x/L)=',num2str(duedx)]);
saveas(gcf,'EX5_1_4.pdf');
hold off

hold off
