close all
clear
load('/Users/Fourthbus/OneDrive/OneDrive - University Of Cambridge/IIA/Projects/3SA1/3SA1_Coding/Week 3-4/Data/4412_9.mat')
figure(1)
title('N.A.C.A. 4412')
hold on
plot(alpha,clswp,'k-d','DisplayName','Re=9e6');
xlabel('\alpha')
ylabel('c_l')
figure(2)
title('N.A.C.A. 4412')
hold on
plot(clswp(1:9),cdswp(1:9),'k-d','DisplayName','Re=9e6');
xlabel('c_l')
ylabel('c_d')
clear
load('/Users/Fourthbus/OneDrive/OneDrive - University Of Cambridge/IIA/Projects/3SA1/3SA1_Coding/Week 3-4/Data/4412_6.mat')
figure(1)
hold on
plot(alpha,clswp,'k-s','DisplayName','Re=6e6');
figure(2)
hold on
plot(clswp(1:9),cdswp(1:9),'k-s','DisplayName','Re=6e6');
clear
load('/Users/Fourthbus/OneDrive/OneDrive - University Of Cambridge/IIA/Projects/3SA1/3SA1_Coding/Week 3-4/Data/4412_3.mat')
figure(1)
hold on
plot(alpha,clswp,'k-o','DisplayName','Re=3e6');
figure(2)
hold on
plot(clswp(1:9),cdswp(1:9),'k-o','DisplayName','Re=3e6');
clear