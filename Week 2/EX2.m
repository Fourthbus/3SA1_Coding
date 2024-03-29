clear
close all

%Input x
x = linspace(0,1,101);

%Input variables for Re's du/dx's
ReL = [1e6 1e7 1e8];
grad = [-.2 0 .2];

%Iterate for different du/dx's where k is each du/dx condition
for k = 1:length(grad);
    
    %Iterate a matrix for ue where i is each x position
    for i = 1:length(x);
        ue(i,k) = grad(k)*x(i)+1;
    end
    
    %Iterate for theta/L where j is each ReL condition
    for j=1:length(ReL);
        
        %Reset laminar flag
        laminar = true;
        
        %Iterate for all x
        for i=1:length(x);
            theta(j,k,i) = sqrt(.45/ReL(j)*(ue(i,k))^-6*ueintbit(0,ue(1,k),x(i),ue(i,k)));
            Rethet(j,k,i) = theta(j,k,i)*ReL(j)*(ue(i,k));
            m(j,k,i) = -ReL(j)*(theta(j,k,i))^2*grad(k);
            H(j,k,i) = thwaites_lookup(m(j,k,i));
            He(j,k,i) = laminar_He(H(j,k,i));
            
            %Check for transition if flow is still laminar 
            if laminar == true;
                if log(Rethet(j,k,i)) >= (18.4*He(j,k,i) - 21.74);
                    
                    %No longer laminar after transition
                    %Set laminar to false, if loop stops
                    laminar = false;
                    display([x(i), Rethet(j,k,i)/1000, ReL(j)/1e6, grad(k)]);
                end
            end
        end
    end
end