function uplotter(alpha,sunt,suts,suls,sutr);
    close
    hold on
    plot(alpha,sunt);
    plot(alpha,suts);
    plot(alpha,suls);
    plot(alpha,sutr);
    legend('natural transition', 'turbulent seperation', 'linear seperation', 'turbulent reattachment');
    title('upper surface')
    hold off
end