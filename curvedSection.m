function [speedFinal] = curvedSection(Vinit,radius,angle)
    %variables
    global index;
    global Cross_Sect_Area;
    global Drag_Coeff;
    global mass;
    global Ptire;
    global Torque;
    global wheel_radius;
    global tStep;
    global tnet;
    global c;
    global speed;
    global Array_limit;
    global energy_count;
    global energy;
    global energy_location;
    global speed_graph;
    global energy_time;
    global torque_per_location;

    %convert to radians
    angle = angle*3.14/180;

    %get distance of curve using radius*angle = arc lenght
    distance = angle*radius;
    
    %make sure distance is from the beginning for energy graph
    offset = energy_location(energy_count);
    
    Vin = Vinit;
    Vmax = sqrt(radius*c*9.81);
    dnet = 0;
    tnet_temp = tnet;
    while Vin < Vmax && dnet < distance
        acceleration = getAccel(Vin,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
        stepLength = Vin*tStep + 0.5*acceleration*tStep^2; %kinematics
        dnet = dnet+stepLength;
        Vfinal = getVfinal(acceleration,tStep,Vin);
        Vin = Vfinal; %next step now
        
        %Find the energy spent 
        energy(energy_count) = getEnergyLost(Vin,Cross_Sect_Area,Drag_Coeff,mass,Ptire); %energy used per time step
        speed_graph(energy_count) = Vin*3.6; %in km/h
        torque_per_location(energy_count) = Torque(index);
        energy_location(energy_count) = dnet+offset;
        energy_location(energy_count+1) = dnet+offset; %next position with same value to make offset work between sections (the next line would point to empty space without this   
        energy_time(energy_count) = tnet_temp+tStep; %%%%%%%
        energy_time(energy_count+1) = tnet_temp+tStep; %%%%%%%
        energy_count = energy_count+1;
        
        index = getIndexOfGraphValues(Vin,speed,Array_limit);
        tnet = tnet + tStep;
        speedFinal = Vin;
    end
    
    if Vin >= Vmax %%finish off the rest of the track at max speed
        while dnet < distance
        index = getIndexOfGraphValues(Vmax,speed,Array_limit);
        acceleration = 0; %(constant speed) getAccel(Vmax,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
        stepLength = Vmax*tStep + 0.5*acceleration*tStep^2;
        dnet = dnet+stepLength;
        tnet = tnet + tStep;
        speedFinal = Vin;
        
        %Find the energy spent 
        energy(energy_count) = getEnergyLost(Vin,Cross_Sect_Area,Drag_Coeff,mass,Ptire); %energy used per time step
        speed_graph(energy_count) = Vin*3.6; %in km/h
        torque_per_location(energy_count) = Torque(index);
        energy_location(energy_count) = dnet+offset;
        energy_location(energy_count+1) = dnet+offset; %next position with same value to make offset work between sections (the next line would point to empty space without this   
        energy_time(energy_count) = tnet_temp+tStep; %%%%%%%
        energy_time(energy_count+1) = tnet_temp+tStep; %%%%%%%
        energy_count = energy_count+1;
        
        end
    end
end