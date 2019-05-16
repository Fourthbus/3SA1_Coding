clear
close all
%input variables
ReL = 2500;
x = linspace(0,1,101);
ue = 1;
%iterate for theta/L
for i=1:length(x);
    theta(i) = sqrt(.45/ReL*(ue)^-6*ueintbit(0,ue,x(i),ue));
end
%plot of theta/L
hold on
plot(x,theta);
xlabel('non dimensional position x/L');
ylabel('non dimensional displacement theta/L');

%calculate blasius
thetab = 0.664/ReL^.5 .* (x).^.5;
%plotting blasius
plot(x,thetab);
legend('analytical','Blasius','location','Southeast');
hold off