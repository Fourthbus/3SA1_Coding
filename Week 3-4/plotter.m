figure(1);
suptitle(section);
subplot(3,1,1)
hold on
plot (alpha,lovdswp)
title('L/D across \alpha')
xlabel('\alpha')
ylabel('L/D')
%legend
hold off

subplot(3,1,2)
hold on
plot(alpha,sunt);
plot(alpha,suts);
plot(alpha,suls);
plot(alpha,sutr);
legend('natural transition', 'turbulent separation', 'linear separation', 'turbulent reattachment','Location','southwest');
xlabel('\alpha')
ylabel('position/section length')
ylim([0,1]);
title('upper surface')
hold off

subplot(3,1,3)
hold on
plot(alpha,slnt);
plot(alpha,slts);
plot(alpha,slls);
plot(alpha,sltr);
legend('natural transition', 'turbulent separation', 'linear separation', 'turbulent reattachment','Location','northwest');
xlabel('\alpha')
ylabel('position/section length')
ylim([0,1]);
title('lower surface')
hold off

set(gcf, 'Position',  [10, 10, 600, 1200])