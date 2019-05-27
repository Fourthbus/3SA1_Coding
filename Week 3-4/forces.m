function [cl cd] = forces(circ,cp,delstarl,thetal,delstaru,thetau);
cl = -2*circ;   %calculate cl

ue = (1-cp).^.5; %convert cp to ue
Hte = (delstaru(end)+delstarl(end)) / (thetau(end)+thetal(end));
thetainf = thetau(end) * ue(1)^((Hte+5)/2);
cd = 2*thetainf;
end