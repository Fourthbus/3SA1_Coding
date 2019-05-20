clear
close all

%Input variables
ReL = 2500;
x = linspace(0,1,101);
ue = 1;

%Iterate for theta/L
for i=1:length(x);
    theta(i) = sqrt(.45/ReL*(ue)^-6*ueintbit(0,ue,x(i),ue));
end

%Plot of Analytical Solution
hold on
plot(x,theta);
xlabel('Non-dimensional position, x/L');
ylabel('Non-dimensional momentum thickness, theta/L');
title('Non-dimensional Momentum Thickness against Non-dimensional Position')

%Calculate Blasius Solution
thetab = 0.664/ReL^.5 .* (x).^.5;

%Plot Blasius Solution
plot(x,thetab);
legend('Analytical','Blasius','location','Southeast');
hold off