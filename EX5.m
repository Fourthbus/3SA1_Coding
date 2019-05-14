clear
close all

%Constants
xmin = -2.5;
xmax = 2.5;
ymin = -2;
ymax = 2;

%Discretisation Steps
nx = 51;
ny = 41;
np = 100;

%Declaration of theta
theta = (0:np)*2*pi/np;

%Declaration of alpha
alpha = 0;

%Iteration for positions and circulation on sphere
for i = 1:np+1;
    xs(i) = cos(theta(i));
    ys(i) = sin(theta(i));
end

%calculate gam with alpha=0
A = build_lhs(xs,ys);
b = build_rhs(xs,ys,alpha);
gam = A\b;

hold on
plot(theta/pi,gam);

%calculate gam with alpha=0.1
alpha = 0.1;
b = build_rhs(xs,ys,alpha);
gam = A\b;
%intrgrate surface circulation i.e. sum of gamma times panel length
Gamma = sum(gam)*(theta(2)-theta(1))

plot(theta/pi,gam);
hold off
legend('alpha=0','alpha=0.1','Location','southeast');
xlabel('theta/pi');
ylabel('gamma');
axis([0 2 -2.5 2.5]);
title('Plot of gammas against pi/theta')

