clear
close all

%Input variables
ReL = 2500;
n = 101;
x = linspace(0,1,n);
ue = 1;

theta = zeros(1,n);   %initialising theta matrix

%Iterate for theta/L
for i=1:length(x);
    theta(i) = sqrt(.45/ReL*(ue)^-6*ueintbit(0,ue,x(i),ue));
end

hold on
plot(x,theta);  %Plot of Analytical Solution

thetab = 0.664/ReL^.5 .* (x).^.5;   %Calculate Blasius Solution

plot(x,thetab); %Plot Blasius Solution

xlabel('Non-dimensional position, x/L');
ylabel('Non-dimensional momentum thickness, \theta/L');
title(['Re_L=',num2str(ReL)]);
legend('Analytical','Blasius','location','Southeast');
hold off
%save pdf
saveas(gcf,'EX1.pdf')