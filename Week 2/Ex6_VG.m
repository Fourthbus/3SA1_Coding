clear
close all

%Defining global variables value
global Re ue0 duedx

%Define simulation conditions
Re = 1e5;
duedxtest = linspace(-0.55,-0.25,31);
ue0 = 1;

%Iteration setting & initial conditions
n = 101;
laminar = true;
x = linspace(0,1,n);

%%initialsing indicators
int = 0;    %natural transition
ils = 0;    %laminar seperation
itr = 0;    %turbulent reattachment
its = 0;    %turbulent seperation

%generating ue matrix


for k = 1:length(duedxtest);
    duedx = duedxtest(k);
    
    for i = 1:n;
        ue(i) = duedx*x(i)+ue0;
    end
    
    %initialising i
    i = 1;
    laminar = true;
    int = 0;    %natural transition
    ils = 0;    %laminar seperation
    itr = 0;    %turbulent reattachment
    its = 0;    %turbulent seperation
    while laminar && i < n; %laminar loop
        i = i+1;    %interpretation
        theta(i) = sqrt(.45/Re*(ue(i))^-6*ueintbit(0,ue(1),x(i),ue(i)));
        Rethet = theta(i)*Re*(ue(i));
        m = -Re*(theta(i))^2*duedx;
        H = thwaites_lookup(m);
        He(i) = laminar_He(H);
        if log(Rethet) >= 18.4*He(i) - 21.74;   %laminar check
            laminar = false;    %laminar flag & end loop
            int = i;    %set pointer
            %disp(['Turbulent Transition at x/L = ' num2str(x(int)) ' at Re_L ' num2str(Re)]);

        elseif m >= 0.09;   %seperation check
            laminar = false;    %also end laminar loop & turbulent formula
            ils = i;
            He(i) = 1.51509;    %set He to seperated value
            %disp(['Laminar Separation at x/L = ' num2str(x(ils)) ' at Re_L ' num2str(Re)])
        end
    end

    %Value for He for Laminar Flow
    He(1) = 1.57258;

    %Calculate deltaE matrix
    deltaE = He.*theta;

    %Turbulent Loop
    while its == 0 && i < n;    
        thick0(1) = theta(i);   %y matrix, value at elemental plate's start
        thick0(2) = deltaE(i);
        i = i+1;
        [delx thickhist] = ode45(@thickdash,[0,x(i)-x(i-1)],thick0);
        theta(i) = thickhist(length(delx),1);   %assign value at elemental plate's end
        deltaE(i) = thickhist(length(delx),2);
        He(i) = deltaE(i)/theta(i);

        %Check for turbulent reattachment
        if ils > 0 && He(i) >= 1.58 && itr == 0;   
            itr = i;
            %disp(['Turbulent Reattachmemt at x/L = ' num2str(x(itr)) ' at Re_L ' num2str(Re)]);
        end

        %Check for turbulent separation
        if He(i) <= 1.46;   %turbulent seperation check
            its = i;
            H=2.803;    %H at seperation
            %disp(['Turbulent Separation at x/L= ' num2str(x(its)) ' at Re_L ' num2str(Re)]);
        end
        if i==101 && its ~=0
            disp(['Critical Velocity Gradient is ' num2str(duedx)]);
            break
        end
    

    %while i < n;    %final loop
     %   theta(i+1) = theta(i)*(ue(i)/ue(i+1))^(H+2);    %theta for cf=0
      %  i = i+1;
       % He(i) = He (its);   %H assumed to remain constant since He is constant
    %end
    end
end

%plotting code -- manually input at command prompt
%figure(1);
%plot(x,He); %plot
%xlabel('non dimensional position x/L');
%ylabel('energy shape factor H_E');
%title(['Re_L=',num2str(Re),' du_e/dx=',num2str(duedx)]);

%figure(2);
%plot(x,theta); %plot
%xlabel('non dimensional position x/L');
%ylabel('non dimensional momentum thickness \theta/L');
%title(['Re_L=',num2str(Re),' du_e/dx=',num2str(duedx)]);
%saveas(gcf,'EX6_2.pdf')