clear
close all

%Defining global variables value
global Re ue0 duedx

Re = 1e7;
ue0 = 1;
duedx = 0; %Not sure if duedx and ue0 is valid.

%Initial values of theta and delta_E
x0 = 0.01;
thick0(1) = 0.037*x0*(Re*x0)^(-1/5);
thick0(2) = 1.80 * thick0(1);

[delx thickhist] = ode45(@thickdash,[0 0.99],thick0);

for i = 1:length(delx);
    
    theta_7(i) = 0.037 * (x0+delx(i)) * (Re * (x0+delx(i)))^(-1/5);
    theta_9(i) = 0.023 * (x0+delx(i)) * (Re * (x0+delx(i)))^(-1/6);
end

hold on
plot(delx+x0,thickhist(1:length(thickhist)));
plot(delx+x0,theta_7);
plot(delx+x0,theta_9);
xlabel('non dimensional position x/L');
ylabel('non dimensional displacement theta/L');
legend('Differential','1/7th Power Law Estimate','1/9th Power Law Estimate','location','Southeast');
hold off