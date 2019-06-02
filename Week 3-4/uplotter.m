function uplotter(alpha,sunt,suts,suls,sutr,slnt,slts,slls,sltr);
    figure(1)
    hold on
    plot(alpha,sunt);
    plot(alpha,suts);
    plot(alpha,suls);
    plot(alpha,sutr);
    legend('natural transition', 'turbulent seperation', 'linear seperation', 'turbulent reattachment');
    title('upper surface')
    hold off
    
    figure(2)
    hold on
    plot(alpha,slnt);
    plot(alpha,slts);
    plot(alpha,slls);
    plot(alpha,sltr);
    legend('natural transition', 'turbulent seperation', 'linear seperation', 'turbulent reattachment');
    title('lower surface')
    hold off
end