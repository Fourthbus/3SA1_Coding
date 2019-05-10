function [infa infb] = panelinf(xa,xb,ya,yb,x,y);
    t = [xb-xa yb-ya]/norm([xb-xa yb-ya]);
    n = [ya-yb xb-xa]/norm([ya-yb xb-xa]);
    r = [x-xa y-ya];
    X = dot(r,t);
    Y = dot(r,n);
    del = norm([xb-xa yb-ya]);
    [infa infb] = refpaninf(del,X,Y);
end
    