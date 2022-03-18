function [speedFinal] = straightSection(Vinit_last_section,radius_next_section,track_length, section)
    %variables
    global index;
    global Cross_Sect_Area;
    global Drag_Coeff;
    global mass;
    global Ptire;
    global Torque;
    global wheel_radius;
    global d_step;
    global tStep;
    global speed;
    global Array_limit;
    global tnet;
    global decelerate;
    global c;
    global d_brake;
    global energy_count;
    global energy;
    global energy_location;
    global speed_graph;
    global energy_time;
    global torque_per_location;
 
    brake_flag = 0;
    tnet_temp = tnet;
    energy_count_temp = energy_count;
    d_brake = 0;
    offset = energy_location(energy_count);

    while brake_flag == 0
        d_left = 0;
        Vinit = Vinit_last_section;
        while d_left <= track_length-d_brake %%Accelerate only zone, no braking allowed
            acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
            
            %Find the energy spent 
            energy(energy_count_temp) = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire); %energy used per time step
            speed_graph(energy_count_temp) = Vinit*3.6; %in km/h
            torque_per_location(energy_count_temp) = Torque(index);
            energy_location(energy_count_temp) = d_left+offset;
            energy_location(energy_count_temp+1) = d_left+offset; %next position with same value to make offset variable work between sections (the next line would point to empty space without this and throw an error  
            energy_time(energy_count_temp) = tnet_temp+tStep; %%%%%%%
            energy_time(energy_count_temp+1) = tnet_temp+tStep; %%%%%%%
            energy_count_temp = energy_count_temp+1;

            Vfinal = getVfinal(acceleration,tStep,Vinit);
            Vinit = Vfinal;
            index = getIndexOfGraphValues(Vinit,speed,Array_limit);
            tnet_temp = tnet_temp + tStep;
            stepLength = Vinit*tStep + 0.5*acceleration*tStep^2;
            d_left = d_left+stepLength;
        end

        
        % braking region, passed the accelerating zone already

        Vout = sqrt(radius_next_section*c*9.81); %the max speed we can do into the next corner 
        disp("track length " + track_length+" Brake distance " + d_brake+" section "+ section+" speed "+ Vinit);
        
        while d_left <= track_length %%braking section
            
            %air and rolling friction deceleration
            a_net = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,0,wheel_radius); %torque is zero and the term is negative

            %braking deceleration included 
            a_net = a_net + decelerate;
            
            %Find the energy spent 
            energy(energy_count_temp) = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire); %energy used per time step
            speed_graph(energy_count_temp) = Vinit*3.6; %in km/h
            torque_per_location(energy_count_temp) = Torque(index);
            energy_location(energy_count_temp) = d_left+offset;
            energy_location(energy_count_temp+1) = d_left+offset; %next position with same value to make offset work between sections (the next line would point to empty space without this   
            energy_time(energy_count_temp) = tnet_temp+tStep; %%%%%%%
            energy_time(energy_count_temp+1) = tnet_temp+tStep; %%%%%%%
            energy_count_temp = energy_count_temp+1;

            Vfinal = getVfinal(a_net,tStep,Vinit);
            Vinit = Vfinal;
            index = getIndexOfGraphValues(Vinit,speed,Array_limit);
            tnet_temp = tnet_temp + tStep;
            stepLength = Vinit*tStep + 0.5*a_net*tStep^2;
            d_left = d_left+stepLength;
        end 
        
        if Vinit>Vout
            %reset the values
            tnet_temp = tnet;
            energy_count_temp = energy_count;
            d_brake = d_brake+d_step;
        elseif d_brake == 0 %didn't reach max corner speed
             brake_flag = 1;
            tnet = tnet_temp;
            energy_count = energy_count_temp;
            speedFinal = Vinit; 
        else %braking distance is acceptable
            brake_flag = 1;
            tnet = tnet_temp;
            energy_count = energy_count_temp;
            speedFinal = sqrt(radius_next_section*c*9.81); %max speed of next section
        end
    end
end