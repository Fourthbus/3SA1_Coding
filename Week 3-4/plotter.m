figure(1);
subplot(4,1,1)
hold on
plot (xs,cp)
%title('Coefficient of Pressure Distribution')
xlabel('xs')
ylabel('c_p')
hold off

subplot(4,1,2)
hold on
plot (alpha,lovdswp)
%title('L/D across \alpha')
xlabel('\alpha')
ylabel('L/D')
legend
hold off

subplot(4,1,3)
hold on
plot(alpha,sunt);
plot(alpha,suts);
plot(alpha,suls);
plot(alpha,sutr);
legend('natural transition', 'turbulent seperation', 'linear seperation', 'turbulent reattachment');
xlabel('\alpha')
ylabel('position/section length')
title('upper surface')
hold off

subplot(4,1,4)
hold on
plot(alpha,slnt);
plot(alpha,slts);
plot(alpha,slls);
plot(alpha,sltr);
legend('natural transition', 'turbulent seperation', 'linear seperation', 'turbulent reattachment');
xlabel('\alpha')
ylabel('position/section length')
title('lower surface')
hold off
