function [int ils itr its delstar theta] = bl_solv(x,cp)

n=length(x);
global Re ue0 duedx

int=0.0;
ils=0.0;
itr=0.0;
its=0.0;
He=1.57258*ones(n,1);

f=0;
theta=zeros(n,1);
laminar=true;

ue(1)=sqrt(1-cp(1));
duedx=ue(1)/x(1);
f= f + ueintbit(0,0,x(1),ue(1));
theta(1)=sqrt(0.45/Re*(ue(1))^(-6)*f);
m=-Re*theta(1)^2*duedx;
H=thwaites_lookup(m);
He(1)=laminar_He(H);
Rethet=Re*ue(1)*theta(1);
delstar(1)=H*theta(1);

if log(Rethet) >=18.4*He(1) -21.74 % Natural Transition
        laminar=0;
        int=1;
    elseif m >= 0.09 % Laminar Separation
        laminar=0;
        ils=1;
        He(1)=1.51509;
end

i=1;
while laminar && i<n
 i=i+1;
 
 ue(i)=sqrt(1-cp(i));
 duedx=(ue(i)-ue(i-1))/(x(i)-x(i-1));
    
   f= f + ueintbit(x(i-1),ue(i-1),x(i),ue(i));
    theta(i)=sqrt(0.45/Re*(ue(i))^(-6)*f);
    
    m=-Re*theta(i)^2*duedx;
    H=thwaites_lookup(m);
    He(i)=laminar_He(H);
    Rethet=Re*ue(i)*theta(i);
    delstar(i)=H*theta(i);
    
    if log(Rethet) >=18.4*He(i) -21.74 % Natural Transition
        laminar=0;
        int=i;
    elseif m >= 0.09 % Laminar Separation
        laminar=0;
        ils=i;
        He(i)=1.51509;
    end
end

deltae=He(i)*theta(i);
thick0=[theta(i) deltae];


while its==0 && i<n % While Turbulent   
ue0=ue(i);
i=i+1;

ue(i)=sqrt(1-cp(i));
duedx=(ue(i)-ue(i-1))/(x(i)-x(i-1));
    
[delx, thickhist] = ode45(@thickdash, [0,x(i)-x(i-1)], thick0);

thick0=[thickhist(end,1) thickhist(end,2)];

He(i)=thickhist(end,2)/thickhist(end,1);
theta(i)=thick0(1);

if He(i)>=1.46
     H=(11*He(i) +15)/(48*He(i) -59);
else
    H=2.803;
    its=i;
end

delstar(i)=H*theta(i);

    if ils~=0 && itr==0 && He(i)>1.58
          itr=i;
    end
    
end

for j=i+1:n
    ue(j)=sqrt(1-cp(j));
    He(j)=He(i);
    theta(j)=theta(i)*(ue(i)/ue(j))^(H+2);
    delstar(j)=H*theta(j);
end