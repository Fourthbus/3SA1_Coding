function [infa infb] = panelinf(xa,xb,ya,yb,x,y);
    %unit vector in t and n directions
    t = [xb-xa yb-ya]/norm([xb-xa yb-ya]);
    n = [ya-yb xb-xa]/norm([ya-yb xb-xa]);
    %r: distance of point of interest to a
    r = [x-xa y-ya];
    %change to catesian in f.o.r. about vortex
    X = dot(r,t);
    Y = dot(r,n);
    del = norm([xb-xa yb-ya]);
    %calculate inf a and inf b with refpaninf
    [infa infb] = refpaninf(del,X,Y);
end