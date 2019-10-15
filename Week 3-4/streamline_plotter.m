%    foil.m
%
%  Script to analyse an aerofoil section using potential flow calculation
%  and boundary layer solver.
%

clear all

global Re

%  Read in the parameter file
caseref = input('Enter case reference: ','s');
parfile = ['Parfiles/' caseref '.txt'];
fprintf(1, '%s\n\n', ['Reading in parameter file: ' parfile])
[section np Re alpha] = par_read(parfile);

%input alpha here
%alpha = input('Alpha (deg): ');
alpha = 0:3:9;

%  Read in the section geometry
secfile = ['Geometry/' section '.surf'];
[xk yk] = textread ( secfile, '%f%f' );

%  Generate high-resolution surface description via cubic splines
nphr = 5*np;
[xshr yshr] = splinefit ( xk, yk, nphr );

%  Resize section so that it lies between (0,0) and (1,0)
[xsin ysin] = resyze ( xshr, yshr );

%  Interpolate to required number of panels (uniform size)
[xs ys] = make_upanels ( xsin, ysin, np );

%  Assemble the lhs of the equations for the potential flow calculation
A = build_lhs ( xs, ys );
Am1 = inv(A);

%  Loop over alpha values
for nalpha = 1:length(alpha)

%    rhs of equations
  alfrad = pi * alpha(nalpha)/180;  %convert deg to rad / incident angel
  b = build_rhs ( xs, ys, alfrad );

%    solve for surface vortex sheet strength
  gam = Am1 * b;

%    calculate cp distribution and overall circulation
  [cp circ] = potential_op ( xs, ys, gam );

%    locate stagnation point and calculate stagnation panel length
  [ipstag fracstag] = find_stag(gam);   %stag between ip and ip+1, frac on panel section: before stag / panel length
  dsstag = sqrt((xs(ipstag+1)-xs(ipstag))^2 + (ys(ipstag+1)-ys(ipstag))^2); %length og stagnation panel section

%    upper surface boundary layer calc

%    first assemble pressure distribution along bl
  clear su cpu
  su(1) = fracstag*dsstag;  %first panel length from stag point
  cpu(1) = cp(ipstag);
  for is = ipstag-1:-1:1
    iu = ipstag - is + 1;
    su(iu) = su(iu-1) + sqrt((xs(is+1)-xs(is))^2 + (ys(is+1)-ys(is))^2);
    cpu(iu) = cp(is);
  end

%    check for stagnation point at end of stagnation panel
  if fracstag < 1e-6
    su(1) = 0.01*su(2);    % go just downstream of stagnation
    uejds = 0.01 * sqrt(1-cpu(2));
    cpu(1) = 1 - uejds^2;
  end

%    boundary layer solver
  [iunt iuls iutr iuts delstaru thetau] = bl_solv_plot ( su, cpu );
  if iunt == 0; sunt(nalpha) = NaN; else  sunt(nalpha) = su(iunt)/su(end); end;
  if iuls == 0; suls(nalpha) = NaN; else  suls(nalpha) = su(iuls)/su(end); end;
  if iutr == 0; sutr(nalpha) = NaN; else  sutr(nalpha) = su(iutr)/su(end); end;
  if iuts == 0; suts(nalpha) = NaN; else  suts(nalpha) = su(iuts)/su(end); end; %lower surface boundary layer calc

%    first assemble pressure distribution along bl
  clear sl cpl
  sl(1) = (1-fracstag) * dsstag;
  cpl(1) = cp(ipstag+1);
  for is = ipstag+2:np+1
    il = is - ipstag;
    sl(il) = sl(il-1) + sqrt((xs(is-1)-xs(is))^2 + (ys(is-1)-ys(is))^2);
    cpl(il) = cp(is);
  end

%    check for stagnation point at end of stagnation panel
  if fracstag > 0.999999
    sl(1) = 0.01*sl(2);    % go just downstream of stagnation
    uejds = 0.01 * sqrt(1-cpl(2));
    cpl(1) = 1 - uejds^2;
  end

%    boundary layer solver
  [ilnt ills iltr ilts delstarl thetal] = bl_solv_plot ( sl, cpl );
  if ilnt == 0; slnt(nalpha) = NaN; else  slnt(nalpha) = sl(ilnt)/sl(end); end;
  if ills == 0; slls(nalpha) = NaN; else  slls(nalpha) = sl(ills)/sl(end); end;
  if iltr == 0; sltr(nalpha) = NaN; else  sltr(nalpha) = sl(iltr)/sl(end); end;
  if ilts == 0; slts(nalpha) = NaN; else  slts(nalpha) = sl(ilts)/sl(end); end;
  
%    lift and drag coefficients
  [Cl Cd] = forces ( circ, cp, delstarl, thetal, delstaru, thetau );

%    copy Cl and Cd into arrays for alpha sweep plots

  clswp(nalpha) = Cl;
  cdswp(nalpha) = Cd;
  lovdswp(nalpha) = Cl/Cd;
  
  figure(2);
  %he
  subplot(2,2,nalpha);
  [xm,ym,psi,c] = stream_plot(xs,ys,gam,alfrad);
  contour(xm,ym,psi,c)
  title(['\alpha = ',num2str(alpha(nalpha)),' deg'])
  hold on
  plot (xs,ys,'k')
  fill (xs,ys,[0.8,0.8,0.8])
  plot (xs(ipstag+ills),ys(ipstag+ills),'mv'); plot (xs(ipstag-iuls+1),ys(ipstag-iuls+1),'m^')    %lam sep
  plot (xs(ipstag+iltr),ys(ipstag+iltr),'g^'); plot (xs(ipstag-iutr+1),ys(ipstag-iutr+1),'gv')    %turb rat
  plot (xs(ipstag+ilnt),ys(ipstag+ilnt),'b+'); plot (xs(ipstag-iunt+1),ys(ipstag-iunt+1),'b+')    %norm tran
  plot (xs(ipstag+ilts),ys(ipstag+ilts),'r>'); plot (xs(ipstag-iuts+1),ys(ipstag-iuts+1),'r>')    %turb sep
  plot (xs(ipstag),ys(ipstag),'k*') %stag point
  axis equal
  hold off
  
  figure(3);
  hold on
  plot (xs,-cp,'DisplayName',[section, ', \alpha = ',num2str(alpha(nalpha)),' deg'])
  xlabel('xs')
  ylabel('-c_p')
  legend
  hold off
end
figure(2)
suptitle(section);
set(gcf, 'Position',  [700, 0, 1700, 750]);

%  save alpha sweep data in summary file

%fname = ['Data/' caseref '.mat'];
%save ( fname, 'xs', 'ys', 'alpha', 'clswp', 'cdswp', 'lovdswp' )
