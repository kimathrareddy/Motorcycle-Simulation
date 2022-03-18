d_brake = 0.1; %in meters, the amount of distance that you brake
    brake_flag = 0;
    % Energy_left_temp = Energy_left; %preserve the original value while you iterate through
    tnet_temp = tnet;

    while brake_flag == 0
        d_left = 0;
        Vinit = Vinit_last_section;
        while d_left <= track_length-d_brake %%Accelerate only zone, no braking allowed

            acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);

            %Find the energy spent 
%             energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire); 
%             Energy_left_temp = Energy_left_temp - energy_lost;

%             if Energy_left<=0
%                 disp("Ran out of battery in section 2")
%             end

            % find the time spent in the d_step
            p = [acceleration/2 Vinit -d_step];
            r = roots(p);
            for n = 1:length(r)
                if r(n)>0
                    time = r(n);
                    break;
                end
            end
            Vfinal = getVfinal(acceleration,time,Vinit);
            Vinit = Vfinal;
            index = getIndexOfGraphValues(Vinit,speed,Array_limit);
            tnet_temp = tnet_temp + time;
            d_left = d_left+d_step;
        end
        
        d_brake = 0.1; %in meters, the amount of distance that you brake
    brake_flag = 0;
    % Energy_left_temp = Energy_left; %preserve the original value while you iterate through
    tnet_temp = tnet;

    while brake_flag == 0
        d_left = 0;
        Vinit = Vinit_last_section;
        while d_left <= track_length-d_brake %%Accelerate only zone, no braking allowed

            acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);

            %Find the energy spent 
%             energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire); 
%             Energy_left_temp = Energy_left_temp - energy_lost;

%             if Energy_left<=0
%                 disp("Ran out of battery in section 2")
%             end

            % find the time spent in the d_step
            p = [acceleration/2 Vinit -d_step];
            r = roots(p);
            for n = 1:length(r)
                if r(n)>0
                    time = r(n);
                    break;
                end
            end
            Vfinal = getVfinal(acceleration,time,Vinit);
            Vinit = Vfinal;
            index = getIndexOfGraphValues(Vinit,speed,Array_limit);
            tnet_temp = tnet_temp + time;
            d_left = d_left+d_step;
        end

        while(d_left<=track_length) % braking region only, passed the accelerating zone already

            %Find the energy spent 
%             energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
%             Energy_left_temp = Energy_left_temp - energy_lost;

%             if Energy_left_temp<=0
%                 disp("Ran out of battery in section 2")
%             end

            % find the time spent in the d_step
            p = [decelerate/2 Vinit -d_step];
            r = roots(p);
            if r(1)>r(2)
                time = r(2); % take the shorter time
            end

            if r(1)<r(2)
                time = r(1); % take the shorter time
            end

            Vfinal = sqrt(Vinit.^2+2*decelerate*d_step); %kinematics equation: vf^2 = vi^2+2*a*d
            Vinit = Vfinal;
            index = getIndexOfGraphValues(Vinit,speed,Array_limit);
            tnet_temp = tnet_temp + time;
            d_left = d_left+d_step;
        end

        if Vfinal <= sqrt(radius_next_section*c*9.81) %next section's radius, if this is true then the speed is acceptible
          brake_flag = 1;
          tnet = tnet_temp;
%         Energy_left = Energy_left_temp;
          speedFinal = Vfinal;
        else
%       reset the values if speed is too fast still
        tnet_temp = tnet;
%       Energy_left_temp = Energy_left;
        d_brake = d_brake+d_step;
        disp("brake distance "+d_brake+" "+" speed at end of brake "+Vinit*3.6+" max corner speed "+sqrt(radius_next_section*c*9.81)*3.6)
        end
    end