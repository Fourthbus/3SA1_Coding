clear
close all
%input x
x = linspace(0,1,101);

%input variables for Re's du/dx=-0.2
ReL = [1e6 1e7 1e8];
grad = -.2;

%iterate a matrix for ue
for i = 1:length(x);
	ue(i) = grad*x(i)+1;
end

%iterate for theta/L
for i=1:length(x);
    for j=1:3;
        theta(i,j) = sqrt(.45/ReL(j)*(ue(i))^-6*ueintbit(0,ue(1),x(i),ue(i)));
    end
end

%plot of theta/L
figure(1)
hold on
plot(x,theta(:,1));
plot(x,theta(:,2));
plot(x,theta(:,3));
xlabel('non dimensional position x/L');
ylabel('non dimensional displacement theta/L');
legend('Re=1e6','Re=1e7','Re=1e8')
hold off

%iterate for du/dx=0
grad = 0;
for i = 1:length(x);
	ue(i) = grad*x(i)+1;
end

%iterate for theta/L
for i=1:length(x);
    for j=1:3;
        theta(i,j) = sqrt(.45/ReL(j)*(ue(i))^-6*ueintbit(0,ue(1),x(i),ue(i)));
    end
end
figure(2)
hold on
plot(x,theta(:,1));
plot(x,theta(:,2));
plot(x,theta(:,3));
xlabel('non dimensional position x/L');
ylabel('non dimensional displacement theta/L');
legend('Re=1e6','Re=1e7','Re=1e8')
hold off

%iterate for du/dx=.2
grad = 0.2;
for i = 1:length(x);
	ue(i) = grad*x(i)+1;
end

%iterate for theta/L
for i=1:length(x);
    for j=1:3;
        theta(i,j) = sqrt(.45/ReL(j)*(ue(i))^-6*ueintbit(0,ue(1),x(i),ue(i)));
    end
end
figure(3)
hold on
plot(x,theta(:,1));
plot(x,theta(:,2));
plot(x,theta(:,3));
xlabel('non dimensional position x/L');
ylabel('non dimensional displacement theta/L');
legend('Re=1e6','Re=1e7','Re=1e8')
hold off