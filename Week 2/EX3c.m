clear
close all

%Discretisation of x
x = linspace(0,1,101);

%Discretisation of ReL and du/dx
ReL = linspace(1e6,1e7,9001);
grad = [-.5];

%initialision matrices storing transitiona and separation locations
int = 0;
ils = 0;

%Iterate for different du/dx's where k is mapped to each du/dx condition
for k = 1:length(grad);
    
    %Iterate a matrix for ue where i is mapped to x position
    for i = 1:length(x);
        ue(i,k) = grad(k)*x(i)+1;
    end
    
    %iterate for theta/L where j is mapped to each ReL condition
    for j=1:length(ReL);
        
        %Imposing the initial condition where flow is laminar
        %Reset laminar flag
        laminar = true;
        
        %Imposing the initial condition that flow is attached
        %Reset separation flag
        separation = false;
        
        %Iterate for theta, Rethet, m, H, and He for various x positions
        for i=1:length(x);
            theta(j,k,i) = sqrt(.45/ReL(j)*(ue(i,k))^-6*ueintbit(0,ue(1,k),x(i),ue(i,k)));
            Rethet(j,k,i) = theta(j,k,i)*ReL(j)*(ue(i,k));
            m(j,k,i) = -ReL(j)*(theta(j,k,i))^2*grad(k);
            H(j,k,i) = thwaites_lookup(m(j,k,i));
            He(j,k,i) = laminar_He(H(j,k,i));
            
            %Check for transition
            if laminar == true;
                if log(Rethet(j,k,i)) >= 18.4*He(j,k,i) - 21.74;
                    laminar = false;
                    int(j,k) = x(i);
                    
                %Assign a large value if there is no transition 
                else
                    int(j,k) = 999;
                end
            end
            
            %record sepetation location
            if separation == false;
                if m(j,k,i) >= 0.09;
                    separation = true;
                    ils(j,k) = x(i);
                    
                %Assign a large value if there is no separation    
                else
                    ils(j,k) = 999;
                end
            end
        end
        
        %Compare the value at which transition occurs before separation
        if ils(j,k) >= int(j,k);
            display(ReL(j));
            
            %Break loop once the lowest ReL is found
            break
        end
    end
end