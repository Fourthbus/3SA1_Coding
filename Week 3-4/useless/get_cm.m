function cm = get_cm(cp,xs,ys)
np = length(xs)-1;  %specifying nodes
cm = 0;
for i = 1:np; %iterating
    ds = sqrt((xs(i) - xs(i+1))^2+(ys(i) - ys(i+1))^2);  %panel length
    costhet = abs(xs(i) - xs(i+1)) / ds;   %cos value
    %cm = cm + cp(i) * ds * (xs(i)-0.25) * costhet;
    cm = cm + (cp(i+1)+cp(i))/2 * costhet * ds * ((xs(i)+xs(i+1))/2 - 1/4);
end
cm;
end
