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
plot([0 1],[1.46 1.46],'--');   %Plot reference value
plot(delx+x0,He);   %Plot He
xlabel('non dimensional position x/L');
ylabel('Energy shape factor H_E');
title(['Re_L=',num2str(Re)]);

%Plotting new duedx
clear He
duedx = -.6;    %input duedx
[delx thickhist] = ode45(@thickdash,[0 0.99],thick0);
for i = 1:length(delx);
    He(i) = thickhist(i,2)/thickhist(i,1);
end

figure(1)
plot(delx+x0,He);   %Plot He

figure(2);
hold on
plot(delx+x0,thickhist(:,1));   %plot theta
plot(delx+x0,thickhist(:,2));   %plot deltaE
xlabel('non dimensional position x/L');
ylabel('non dimensional thickness');
legend('\theta','\delta_E','location','Northwest');
title(['Re_L=',num2str(Re),' d(u_e/U)/d(x/L)=',num2str(duedx)]);
saveas(gcf,'EX5_1_3.pdf');
hold off
hold off
