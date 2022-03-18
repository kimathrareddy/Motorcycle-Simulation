function [speedFinal] = curvedSection(Vinit,radius,angle)
    %variables
    global index;
    global Cross_Sect_Area;
    global Drag_Coeff;
    global mass;
    global Ptire;
    global Torque;
    global wheel_radius;
    global d_step;
    global speed;
    global Array_limit;
    global tnet;
    global c;

    %convert to radians
    angle = angle*3.14/180;

    %get distance of curve using radius*angle = arc lenght
    distance = angle*radius;

    %loop through the d_step until the length of the arc is travelled
    dLeft = distance;
    flag = 0;
    while dLeft>0
        if Vinit>sqrt(radius*c*9.81) %the max corner speed that the bike does can do in that curve
            Vinit = sqrt(radius*c*9.81);
            flag = 1;
        end

        acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);

        %Find the energy spent 
%         energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire); 
%         Energy_left = Energy_left - energy_lost;

%         if Energy_left<=0
%             disp("Ran out of battery in section 1")
%         end

        % find the time spent in the d_step
        p = [acceleration/2 Vinit -d_step]; %kinematics formula: d = Vi*t + 0.5*a*t^2
        r = roots(p);
        for n = 1:length(r) %find the positive root
            if r(n)>0
                time = r(n);
                break;
            end
        end

        if flag == 0 %if the max corner speed hasn't been reached 
          Vfinal = getVfinal(acceleration,time,Vinit);
          Vinit = Vfinal;
        end

        index = getIndexOfGraphValues(Vinit,speed,Array_limit);

        tnet = tnet + time;
        dLeft = dLeft-d_step;
    end
    speedFinal = Vinit;
    index_out = index;
    tout = tnet;
end