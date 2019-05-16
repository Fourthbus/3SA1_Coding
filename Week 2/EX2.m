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
        theta1(j,i) = sqrt(.45/ReL(j)*(ue(i))^-6*ueintbit(0,ue(1),x(i),ue(i)));
        ReT1(j,i)=theta1(j,i)*ReL(j)*(ue(i));
    end
end

%iterate for du/dx=0
grad = 0;
for i = 1:length(x);
	ue(i) = grad*x(i)+1;
end

%iterate for theta/L
for i=1:length(x);
    for j=1:3;
        theta2(j,i) = sqrt(.45/ReL(j)*(ue(i))^-6*ueintbit(0,ue(1),x(i),ue(i)));
    end
end

%iterate for du/dx=.2
grad = 0.2;
for i = 1:length(x);
	ue(i) = grad*x(i)+1;
end

%iterate for theta/L
for i=1:length(x);
    for j=1:3;
        theta3(j,i) = sqrt(.45/ReL(j)*(ue(i))^-6*ueintbit(0,ue(1),x(i),ue(i)));
    end
end