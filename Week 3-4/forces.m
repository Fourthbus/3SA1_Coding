function [cl cd] = forces(circ,cp,delstarl,thetal,delstaru,thetau);
cl = -2*circ;   %calculate cl

ue_te = (1-cp(end)).^.5; %convert cp to ue
theta_te = (thetau(end)+thetal(end));
delstar_te = (delstaru(end)+delstarl(end));
Hte = delstar_te / theta_te;
thetainf = theta_te * ue_te^((Hte+5)/2);
cd = 2*thetainf;
end