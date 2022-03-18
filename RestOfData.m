

% Section 3
radius = 67;
angle = 61;
%convert to radians
angle = angle*3.14/180;

%get distance of curve using radius*angle = arc lenght
distance = angle*radius;

%find Vlimit in m/s, none for this section because there is a straightaway
%after
dLeft = distance;
flag = 0;
while dLeft>0
    
    c = 0.6;
    
    if Vinit>sqrt(radius*c*9.81) %the max corner speed
        Vinit = sqrt(radius*c*9.81);
        flag = 1;
    end
    
    acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
    %Find the energy spent 
    energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
    Energy_left = Energy_left - energy_lost;
    
    if Energy_left<=0
        disp("Ran out of battery in section 1")
    end
    
    % find the time spent in the d_step
    p = [acceleration/2 Vinit -d_step];
    r = roots(p);
    for n = 1:length(r)
        if r(n)>0
            time = r(n);
            break;
        end
    end
    
    if flag == 0
      Vfinal = getVfinal(acceleration,time,Vinit);
      Vinit = Vfinal;
    end
    index = getIndexOfGraphValues(Vinit,speed,121);
    
    tnet = tnet + time;
    dLeft = dLeft-d_step;
end

Vinit_last_section = Vinit;

T3 = tnet;

% Section 4
lenght = 368;
d_brake = 0.1; %in meters
brake_flag = 0;
Energy_left_temp = Energy_left;
tnet_temp = tnet;

while brake_flag == 0
    d_left = 0;
    Vinit = Vinit_last_section;
    while d_left <= lenght-d_brake
    
        acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
        %Find the energy spent 
        energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
        Energy_left_temp = Energy_left_temp - energy_lost;
    
        if Energy_left<=0
            disp("Ran out of battery in section 2")
        end
    
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
        index = getIndexOfGraphValues(Vinit,speed,121);
        tnet_temp = tnet_temp + time;
        d_left = d_left+d_step;
    end
    
    while(d_left<=lenght) % braking region
        
        %Find the energy spent 
        energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
        Energy_left_temp = Energy_left_temp - energy_lost;
    
        if Energy_left_temp<=0
            disp("Ran out of battery in section 2")
        end
    
        % find the time spent in the d_step
        p = [decelerate/2 Vinit -d_step];
        r = roots(p);
        if r(1)>r(2)
            time = r(2); % take the shorter time
        end
        
        if r(1)<r(2)
            time = r(1); % take the shorter time
        end
        
        Vfinal = sqrt(Vinit.^2+2*decelerate*d_step);
        Vinit = Vfinal;
        index = getIndexOfGraphValues(Vinit,speed,121);
        tnet_temp = tnet_temp + time;
        d_left = d_left+d_step;
    end

    if Vfinal <= sqrt(98*c*9.81) %next section's radius
      brake_flag = 1;
      tnet = tnet_temp;
      Energy_left = Energy_left_temp;
    end
    %reset the values if speed is too much still
    tnet_temp = tnet;
    Energy_left_temp = Energy_left;
    d_brake = d_brake+d_step;
    disp(d_brake+" "+Vinit*3.6+" "+sqrt(98*c*9.81)*3.6)
end

T4 = tnet;

%Section 5
radius = 74;
angle = 75;
%convert to radians
angle = angle*3.14/180;

%get distance of curve using radius*angle = arc lenght
distance = angle*radius;

%find Vlimit in m/s, none for this section because there is a straightaway
%after
dLeft = distance;
flag = 0;
while dLeft>0
    
    c = 0.6;
    
    if Vinit>sqrt(radius*c*9.81) %the max corner speed
        Vinit = sqrt(radius*c*9.81);
        flag = 1;
    end
    
    acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
    %Find the energy spent 
    energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
    Energy_left = Energy_left - energy_lost;
    
    if Energy_left<=0
        disp("Ran out of battery in section 1")
    end
    
    % find the time spent in the d_step
    p = [acceleration/2 Vinit -d_step];
    r = roots(p);
    for n = 1:length(r)
        if r(n)>0
            time = r(n);
            break;
        end
    end
    
    if flag == 0
      Vfinal = getVfinal(acceleration,time,Vinit);
      Vinit = Vfinal;
    end
    index = getIndexOfGraphValues(Vinit,speed,121);
    
    tnet = tnet + time;
    dLeft = dLeft-d_step;
end

T5 = tnet;

Vinit_last_section = Vinit;

% %Section 6
lenght = 422;
d_brake = 0.1; %in meters
brake_flag = 0;
Energy_left_temp = Energy_left;
tnet_temp = tnet;

while brake_flag == 0
    d_left = 0;
    Vinit = Vinit_last_section;
    while d_left <= lenght-d_brake
    
        acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
        %Find the energy spent 
        energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
        Energy_left_temp = Energy_left_temp - energy_lost;
    
        if Energy_left<=0
            disp("Ran out of battery in section 2")
        end
    
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
        index = getIndexOfGraphValues(Vinit,speed,121);
        tnet_temp = tnet_temp + time;
        d_left = d_left+d_step;
    end
    
    while(d_left<=lenght) % braking region
        
        %Find the energy spent 
        energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
        Energy_left_temp = Energy_left_temp - energy_lost;
    
        if Energy_left_temp<=0
            disp("Ran out of battery in section 2")
        end
    
        % find the time spent in the d_step
        p = [decelerate/2 Vinit -d_step];
        r = roots(p);
        if r(1)>r(2)
            time = r(2); % take the shorter time
        end
        
        if r(1)<r(2)
            time = r(1); % take the shorter time
        end
        
        Vfinal = sqrt(Vinit.^2+2*decelerate*d_step);
        Vinit = Vfinal;
        index = getIndexOfGraphValues(Vinit,speed,121);
        tnet_temp = tnet_temp + time;
        d_left = d_left+d_step;
    end

    if Vfinal <= sqrt(64*c*9.81) %next section's radius
      brake_flag = 1;
      tnet = tnet_temp;
      Energy_left = Energy_left_temp;
    end
    %reset the values if speed is too much still
    tnet_temp = tnet;
    Energy_left_temp = Energy_left;
    d_brake = d_brake+d_step;
    disp(d_brake+" "+Vinit*3.6+" "+sqrt(64*c*9.81)*3.6)
end

T6 = tnet;

% Section 7
radius = 58;
angle = 50;
%convert to radians
angle = angle*3.14/180;

%get distance of curve using radius*angle = arc lenght
distance = angle*radius;

%find Vlimit in m/s, none for this section because there is a straightaway
%after
dLeft = distance;
flag = 0;
while dLeft>0
    
    c = 0.6;
    
    if Vinit>sqrt(radius*c*9.81) %the max corner speed
        Vinit = sqrt(radius*c*9.81);
        flag = 1;
    end
    
    acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
    %Find the energy spent 
    energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
    Energy_left = Energy_left - energy_lost;
    
    if Energy_left<=0
        disp("Ran out of battery in section 1")
    end
    
    % find the time spent in the d_step
    p = [acceleration/2 Vinit -d_step];
    r = roots(p);
    for n = 1:length(r)
        if r(n)>0
            time = r(n);
            break;
        end
    end
    
    if flag == 0
      Vfinal = getVfinal(acceleration,time,Vinit);
      Vinit = Vfinal;
    end
    index = getIndexOfGraphValues(Vinit,speed,121);
    
    tnet = tnet + time;
    dLeft = dLeft-d_step;
end

T7 = tnet;

Vinit_last_section = Vinit;

% Section 8
lenght = 117;

d_brake = 0.1; %in meters
brake_flag = 0;
Energy_left_temp = Energy_left;
tnet_temp = tnet;

while brake_flag == 0
    d_left = 0;
    Vinit = Vinit_last_section;
    while d_left <= lenght-d_brake
    
        acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
        %Find the energy spent 
        energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
        Energy_left_temp = Energy_left_temp - energy_lost;
    
        if Energy_left<=0
            disp("Ran out of battery in section 2")
        end
    
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
        index = getIndexOfGraphValues(Vinit,speed,121);
        tnet_temp = tnet_temp + time;
        d_left = d_left+d_step;
    end
    
    while(d_left<=lenght) % braking region
        
        %Find the energy spent 
        energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
        Energy_left_temp = Energy_left_temp - energy_lost;
    
        if Energy_left_temp<=0
            disp("Ran out of battery in section 2")
        end
    
        % find the time spent in the d_step
        p = [decelerate/2 Vinit -d_step];
        r = roots(p);
        if r(1)>r(2)
            time = r(2); % take the shorter time
        end
        
        if r(1)<r(2)
            time = r(1); % take the shorter time
        end
        
        Vfinal = sqrt(Vinit.^2+2*decelerate*d_step);
        Vinit = Vfinal;
        index = getIndexOfGraphValues(Vinit,speed,121);
        tnet_temp = tnet_temp + time;
        d_left = d_left+d_step;
    end

    if Vfinal <= sqrt(54*c*9.81) %next section's radius
      brake_flag = 1;
      tnet = tnet_temp;
      Energy_left = Energy_left_temp;
    end
    %reset the values if speed is too much still
    tnet_temp = tnet;
    Energy_left_temp = Energy_left;
    d_brake = d_brake+d_step;
    disp(d_brake+" "+Vinit*3.6+" "+sqrt(54*c*9.81)*3.6)
end

T8 = tnet;

%Section 9
radius = 54;
angle = 56;
%convert to radians
angle = angle*3.14/180;

%get distance of curve using radius*angle = arc lenght
distance = angle*radius;

%find Vlimit in m/s, none for this section because there is a straightaway
%after
dLeft = distance;
flag = 0;
while dLeft>0
    
    c = 0.6;
    
    if Vinit>sqrt(radius*c*9.81) %the max corner speed
        Vinit = sqrt(radius*c*9.81);
        flag = 1;
    end
    
    acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
    %Find the energy spent 
    energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
    Energy_left = Energy_left - energy_lost;
    
    if Energy_left<=0
        disp("Ran out of battery in section 1")
    end
    
    % find the time spent in the d_step
    p = [acceleration/2 Vinit -d_step];
    r = roots(p);
    for n = 1:length(r)
        if r(n)>0
            time = r(n);
            break;
        end
    end
    
    if flag == 0
      Vfinal = getVfinal(acceleration,time,Vinit);
      Vinit = Vfinal;
    end
    index = getIndexOfGraphValues(Vinit,speed,121);
    
    tnet = tnet + time;
    dLeft = dLeft-d_step;
end

T9 = tnet;

Vinit_last_section = Vinit;

%Section 10
lenght = 345;

d_brake = 0.1; %in meters
brake_flag = 0;
Energy_left_temp = Energy_left;
tnet_temp = tnet;

while brake_flag == 0
    d_left = 0;
    Vinit = Vinit_last_section;
    while d_left <= lenght-d_brake
    
        acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
        %Find the energy spent 
        energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
        Energy_left_temp = Energy_left_temp - energy_lost;
    
        if Energy_left<=0
            disp("Ran out of battery in section 2")
        end
    
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
        index = getIndexOfGraphValues(Vinit,speed,121);
        tnet_temp = tnet_temp + time;
        d_left = d_left+d_step;
    end
    
    while(d_left<=lenght) % braking region
        
        %Find the energy spent 
        energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
        Energy_left_temp = Energy_left_temp - energy_lost;
    
        if Energy_left_temp<=0
            disp("Ran out of battery in section 2")
        end
    
        % find the time spent in the d_step
        p = [decelerate/2 Vinit -d_step];
        r = roots(p);
        if r(1)>r(2)
            time = r(2); % take the shorter time
        end
        
        if r(1)<r(2)
            time = r(1); % take the shorter time
        end
        
        Vfinal = sqrt(Vinit.^2+2*decelerate*d_step);
        Vinit = Vfinal;
        index = getIndexOfGraphValues(Vinit,speed,121);
        tnet_temp = tnet_temp + time;
        d_left = d_left+d_step;
    end

    if Vfinal <= sqrt(49*c*9.81) %next section's radius
      brake_flag = 1;
      tnet = tnet_temp;
      Energy_left = Energy_left_temp;
    end
    %reset the values if speed is too much still
    tnet_temp = tnet;
    Energy_left_temp = Energy_left;
    d_brake = d_brake+d_step;
    disp(d_brake+" "+Vinit*3.6+" "+sqrt(49*c*9.81)*3.6)
end

T10 = tnet;

%Section 11
radius = 49;
angle = 79;
%convert to radians
angle = angle*3.14/180;

%get distance of curve using radius*angle = arc lenght
distance = angle*radius;

%find Vlimit in m/s, none for this section because there is a straightaway
%after
dLeft = distance;
flag = 0;
while dLeft>0
    
    c = 0.6;
    
    if Vinit>sqrt(radius*c*9.81) %the max corner speed
        Vinit = sqrt(radius*c*9.81);
        flag = 1;
    end
    
    acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
    %Find the energy spent 
    energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
    Energy_left = Energy_left - energy_lost;
    
    if Energy_left<=0
        disp("Ran out of battery in section 1")
    end
    
    % find the time spent in the d_step
    p = [acceleration/2 Vinit -d_step];
    r = roots(p);
    for n = 1:length(r)
        if r(n)>0
            time = r(n);
            break;
        end
    end
    
    if flag == 0
      Vfinal = getVfinal(acceleration,time,Vinit);
      Vinit = Vfinal;
    end
    index = getIndexOfGraphValues(Vinit,speed,121);
    
    tnet = tnet + time;
    dLeft = dLeft-d_step;
end

T11 = tnet;

Vinit_last_section = Vinit;

%Section 12
lenght = 226;

d_brake = 0.1; %in meters
brake_flag = 0;
Energy_left_temp = Energy_left;
tnet_temp = tnet;

while brake_flag == 0
    d_left = 0;
    Vinit = Vinit_last_section;
    while d_left <= lenght-d_brake
    
        acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
        %Find the energy spent 
        energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
        Energy_left_temp = Energy_left_temp - energy_lost;
    
        if Energy_left<=0
            disp("Ran out of battery in section 2")
        end
    
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
        index = getIndexOfGraphValues(Vinit,speed,121);
        tnet_temp = tnet_temp + time;
        d_left = d_left+d_step;
    end
    
    while(d_left<=lenght) % braking region
        
        %Find the energy spent 
        energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
        Energy_left_temp = Energy_left_temp - energy_lost;
    
        if Energy_left_temp<=0
            disp("Ran out of battery in section 2")
        end
    
        % find the time spent in the d_step
        p = [decelerate/2 Vinit -d_step];
        r = roots(p);
        if r(1)>r(2)
            time = r(2); % take the shorter time
        end
        
        if r(1)<r(2)
            time = r(1); % take the shorter time
        end
        
        Vfinal = sqrt(Vinit.^2+2*decelerate*d_step);
        Vinit = Vfinal;
        index = getIndexOfGraphValues(Vinit,speed,121);
        tnet_temp = tnet_temp + time;
        d_left = d_left+d_step;
    end

    if Vfinal <= sqrt(55*c*9.81) %next section's radius
      brake_flag = 1;
      tnet = tnet_temp;
      Energy_left = Energy_left_temp;
    end
    %reset the values if speed is too much still
    tnet_temp = tnet;
    Energy_left_temp = Energy_left;
    d_brake = d_brake+d_step;
    disp(d_brake+" "+Vinit*3.6+" "+sqrt(55*c*9.81)*3.6)
end

T12 = tnet;

%Section 13
radius = 45;
angle = 89;
%convert to radians
angle = angle*3.14/180;

%get distance of curve using radius*angle = arc lenght
distance = angle*radius;

%find Vlimit in m/s, none for this section because there is a straightaway
%after
dLeft = distance;
flag = 0;
while dLeft>0
    
    c = 0.6;
    
    if Vinit>sqrt(radius*c*9.81) %the max corner speed
        Vinit = sqrt(radius*c*9.81);
        flag = 1;
    end
    
    acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
    %Find the energy spent 
    energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
    Energy_left = Energy_left - energy_lost;
    
    if Energy_left<=0
        disp("Ran out of battery in section 1")
    end
    
    % find the time spent in the d_step
    p = [acceleration/2 Vinit -d_step];
    r = roots(p);
    for n = 1:length(r)
        if r(n)>0
            time = r(n);
            break;
        end
    end
    
    if flag == 0
      Vfinal = getVfinal(acceleration,time,Vinit);
      Vinit = Vfinal;
    end
    index = getIndexOfGraphValues(Vinit,speed,121);
    
    tnet = tnet + time;
    dLeft = dLeft-d_step;
end

T13 = tnet;

Vinit_last_section = Vinit;

%Section 14
lenght = 48;

d_brake = 0.1; %in meters
brake_flag = 0;
Energy_left_temp = Energy_left;
tnet_temp = tnet;

while brake_flag == 0
    d_left = 0;
    Vinit = Vinit_last_section;
    while d_left <= lenght-d_brake
    
        acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
        %Find the energy spent 
        energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
        Energy_left_temp = Energy_left_temp - energy_lost;
    
        if Energy_left<=0
            disp("Ran out of battery in section 2")
        end
    
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
        index = getIndexOfGraphValues(Vinit,speed,121);
        tnet_temp = tnet_temp + time;
        d_left = d_left+d_step;
    end
    
    while(d_left<=lenght) % braking region
        
        %Find the energy spent 
        energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
        Energy_left_temp = Energy_left_temp - energy_lost;
    
        if Energy_left_temp<=0
            disp("Ran out of battery in section 2")
        end
    
        % find the time spent in the d_step
        p = [decelerate/2 Vinit -d_step];
        r = roots(p);
        if r(1)>r(2)
            time = r(2); % take the shorter time
        end
        
        if r(1)<r(2)
            time = r(1); % take the shorter time
        end
        
        Vfinal = sqrt(Vinit.^2+2*decelerate*d_step);
        Vinit = Vfinal;
        index = getIndexOfGraphValues(Vinit,speed,121);
        tnet_temp = tnet_temp + time;
        d_left = d_left+d_step;
    end

    if Vfinal <= sqrt(117*c*9.81) %next section's radius
      brake_flag = 1;
      tnet = tnet_temp;
      Energy_left = Energy_left_temp;
    end
    %reset the values if speed is too much still
    tnet_temp = tnet;
    Energy_left_temp = Energy_left;
    d_brake = d_brake+d_step;
    disp(d_brake+" "+Vinit*3.6+" "+sqrt(117*c*9.81)*3.6)
end

T14 = tnet;

Vinit_last_section = Vinit;

%Section 15-16
radius = 94;
angle = 180;
%convert to radians
angle = angle*3.14/180;

%get distance of curve using radius*angle = arc lenght
lenght = angle*radius;

d_brake = 0.1; %in meters
brake_flag = 0;
Energy_left_temp = Energy_left;
tnet_temp = tnet;

while brake_flag == 0
    d_left = 0;
    Vinit = Vinit_last_section;
    while d_left <= lenght-d_brake
    
        acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
        %Find the energy spent 
        energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
        Energy_left_temp = Energy_left_temp - energy_lost;
    
        if Energy_left<=0
            disp("Ran out of battery in section 2")
        end
    
        % find the time spent in the d_step
        p = [acceleration/2 Vinit -d_step];
        r = roots(p);
        for n = 1:length(r)
            if r(n)>0
                time = r(n);
                break;
            end
        end
        
        if Vinit>sqrt(radius*c*9.81) %the max corner speed
        Vinit = sqrt(radius*c*9.81);
        else
        Vfinal = getVfinal(acceleration,time,Vinit);
        Vinit = Vfinal;
        index = getIndexOfGraphValues(Vinit,speed,Array_index);
        tnet_temp = tnet_temp + time;
        d_left = d_left+d_step;
        end
    end
    
    while(d_left<=lenght) % braking region
        
        %Find the energy spent 
        energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire); 
        Energy_left_temp = Energy_left_temp - energy_lost;
    
        if Energy_left_temp<=0
            disp("Ran out of battery in section 2")
        end
    
        % find the time spent in the d_step
        p = [decelerate/2 Vinit -d_step];
        r = roots(p);
        if r(1)>r(2) && r(2)>0
            time = r(2); % take the shorter time
        end
        
        if r(1)<r(2) && r(1)>0
            time = r(1); % take the shorter time
        end
        
        Vfinal = sqrt(Vinit.^2+2*decelerate*d_step);
        Vinit = Vfinal;
        index = getIndexOfGraphValues(Vinit,speed,Array_limit);
        tnet_temp = tnet_temp + time;
        d_left = d_left+d_step;
    end

    if Vfinal <= sqrt(86*c*9.81) %next section's radius
      brake_flag = 1;
      tnet = tnet_temp;
      Energy_left = Energy_left_temp;
    end
    %reset the values if speed is too fast still
    tnet_temp = tnet;
    Energy_left_temp = Energy_left;
    d_brake = d_brake+d_step;
    disp(d_brake+" "+Vinit*3.6+" "+sqrt(86*c*9.81)*3.6)
end

T15_16 = tnet; 

%Section 17
radius = 74;
angle = 176;
%convert to radians
angle = angle*3.14/180;

%get distance of curve using radius*angle = arc lenght
distance = angle*radius;

%find Vlimit in m/s, none for this section because there is a straightaway
%after
dLeft = distance;
flag = 0;
while dLeft>0
    
    c = 0.6;
    
    if Vinit>sqrt(radius*c*9.81) %the max corner speed
        Vinit = sqrt(radius*c*9.81);
        flag = 1;
    end
    
    acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
    %Find the energy spent 
    energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
    Energy_left = Energy_left - energy_lost;
    
    if Energy_left<=0
        disp("Ran out of battery in section 1")
    end
    
    % find the time spent in the d_step
    p = [acceleration/2 Vinit -d_step];
    r = roots(p);
    for n = 1:length(r)
        if r(n)>0
            time = r(n);
            break;
        end
    end
    
    if flag == 0
      Vfinal = getVfinal(acceleration,time,Vinit);
      Vinit = Vfinal;
    end
    index = getIndexOfGraphValues(Vinit,speed,121);
    
    tnet = tnet + time;
    dLeft = dLeft-d_step;
end

T17 = tnet;

Vinit_last_section = Vinit;

%Section 18
lenght = 67;

d_brake = 0.1; %in meters
brake_flag = 0;
Energy_left_temp = Energy_left;
tnet_temp = tnet;

while brake_flag == 0
    d_left = 0;
    Vinit = Vinit_last_section;
    while d_left <= lenght-d_brake
    
        acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
        %Find the energy spent 
        energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
        Energy_left_temp = Energy_left_temp - energy_lost;
    
        if Energy_left<=0
            disp("Ran out of battery in section 2")
        end
    
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
        index = getIndexOfGraphValues(Vinit,speed,121);
        tnet_temp = tnet_temp + time;
        d_left = d_left+d_step;
    end
    
    while(d_left<=lenght) % braking region
        
        %Find the energy spent 
        energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
        Energy_left_temp = Energy_left_temp - energy_lost;
    
        if Energy_left_temp<=0
            disp("Ran out of battery in section 2")
        end
    
        % find the time spent in the d_step
        p = [decelerate/2 Vinit -d_step];
        r = roots(p);
        if r(1)>r(2)
            time = r(2); % take the shorter time
        end
        
        if r(1)<r(2)
            time = r(1); % take the shorter time
        end
        
        Vfinal = sqrt(Vinit.^2+2*decelerate*d_step);
        Vinit = Vfinal;
        index = getIndexOfGraphValues(Vinit,speed,121);
        tnet_temp = tnet_temp + time;
        d_left = d_left+d_step;
    end

    if Vfinal <= sqrt(94*c*9.81) %next section's radius
      brake_flag = 1;
      tnet = tnet_temp;
      Energy_left = Energy_left_temp;
    end
    %reset the values if speed is too much still
    tnet_temp = tnet;
    Energy_left_temp = Energy_left;
    d_brake = d_brake+d_step;
    disp(d_brake+" "+Vinit*3.6+" "+sqrt(94*c*9.81)*3.6)
end

T18 = tnet;

%Section 19
radius = 60;
angle = 65;
%convert to radians
angle = angle*3.14/180;

%get distance of curve using radius*angle = arc lenght
distance = angle*radius;

%find Vlimit in m/s, none for this section because there is a straightaway
%after
dLeft = distance;
flag = 0;
while dLeft>0
    
    c = 0.6;
    
    if Vinit>sqrt(radius*c*9.81) %the max corner speed
        Vinit = sqrt(radius*c*9.81);
        flag = 1;
    end
    
    acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
    %Find the energy spent 
    energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
    Energy_left = Energy_left - energy_lost;
    
    if Energy_left<=0
        disp("Ran out of battery in section 1")
    end
    
    % find the time spent in the d_step
    p = [acceleration/2 Vinit -d_step];
    r = roots(p);
    for n = 1:length(r)
        if r(n)>0
            time = r(n);
            break;
        end
    end
    
    if flag == 0
      Vfinal = getVfinal(acceleration,time,Vinit);
      Vinit = Vfinal;
    end
    index = getIndexOfGraphValues(Vinit,speed,121);
    
    tnet = tnet + time;
    dLeft = dLeft-d_step;
end

T19 = tnet;

Vinit_last_section = Vinit;

%Section 20
lenght = 213;

d_brake = 0.1; %in meters
brake_flag = 0;
Energy_left_temp = Energy_left;
tnet_temp = tnet;

while brake_flag == 0
    d_left = 0;
    Vinit = Vinit_last_section;
    while d_left <= lenght-d_brake
    
        acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
        %Find the energy spent 
        energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
        Energy_left_temp = Energy_left_temp - energy_lost;
    
        if Energy_left<=0
            disp("Ran out of battery in section 2")
        end
    
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
        index = getIndexOfGraphValues(Vinit,speed,121);
        tnet_temp = tnet_temp + time;
        d_left = d_left+d_step;
    end
    
    while(d_left<=lenght) % braking region
        
        %Find the energy spent 
        energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
        Energy_left_temp = Energy_left_temp - energy_lost;
    
        if Energy_left_temp<=0
            disp("Ran out of battery in section 2")
        end
    
        % find the time spent in the d_step
        p = [decelerate/2 Vinit -d_step];
        r = roots(p);
        if r(1)>r(2)
            time = r(2); % take the shorter time
        end
        
        if r(1)<r(2)
            time = r(1); % take the shorter time
        end
        
        Vfinal = sqrt(Vinit.^2+2*decelerate*d_step);
        Vinit = Vfinal;
        index = getIndexOfGraphValues(Vinit,speed,121);
        tnet_temp = tnet_temp + time;
        d_left = d_left+d_step;
    end

    if Vfinal <= sqrt(83*c*9.81) %next section's radius
      brake_flag = 1;
      tnet = tnet_temp;
      Energy_left = Energy_left_temp;
    end
    %reset the values if speed is too much still
    tnet_temp = tnet;
    Energy_left_temp = Energy_left;
    d_brake = d_brake+d_step;
    disp(d_brake+" "+Vinit*3.6+" "+sqrt(83*c*9.81)*3.6)
end

T20 = tnet;

%Section 21
radius = 83;
angle = 76;
%convert to radians
angle = angle*3.14/180;

%get distance of curve using radius*angle = arc lenght
distance = angle*radius;

%find Vlimit in m/s, none for this section because there is a straightaway
%after
dLeft = distance;
flag = 0;
while dLeft>0
    
    c = 0.6;
    
    if Vinit>sqrt(radius*c*9.81) %the max corner speed
        Vinit = sqrt(radius*c*9.81);
        flag = 1;
    end
    
    acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
    %Find the energy spent 
    energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
    Energy_left = Energy_left - energy_lost;
    
    if Energy_left<=0
        disp("Ran out of battery in section 1")
    end
    
    % find the time spent in the d_step
    p = [acceleration/2 Vinit -d_step];
    r = roots(p);
    for n = 1:length(r)
        if r(n)>0
            time = r(n);
            break;
        end
    end
    
    if flag == 0
      Vfinal = getVfinal(acceleration,time,Vinit);
      Vinit = Vfinal;
    end
    index = getIndexOfGraphValues(Vinit,speed,121);
    
    tnet = tnet + time;
    dLeft = dLeft-d_step;
end

T21 = tnet;


%Section 22
lenght = 804.6;

dLeft = lenght;

while dLeft>0
    
    acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    
    %Find the energy spent 
    energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,d_step,MotEff); 
    Energy_left = Energy_left - energy_lost;
    
    if Energy_left<=0
        disp("Ran out of battery in section 1")
    end
    
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
    disp(Vinit*3.6+" "+time)
    index = getIndexOfGraphValues(Vinit,speed,Array_limit);
    
    tnet = tnet + time;
    dLeft = dLeft-d_step;
end

T22 = tnet;

tnet_clone = tnet;

minutes = 0;
while tnet_clone-60 > 0
    minutes = minutes+1;
    tnet_clone = tnet_clone-60;
end
seconds = tnet_clone;


disp("Battery capacity remaining is: "+Energy_left/3600+" Wh")
disp("Time to complete lap is: "+minutes+":"+seconds)
disp("Final speed is: "+Vinit*3.6+" km/h")
disp("Time per section (in seconds)")
disp(T1+" Section 1")
disp(T2-T1+" Section 2")
disp(T3-T2+" Section 3")
disp(T4-T3+" Section 4")
disp(T5-T4+" Section 5")
disp(T6-T5+" Section 6")
disp(T7-T6+" Section 7")
disp(T8-T7+" Section 8")
disp(T9-T8+" Section 9")
disp(T10-T9+" Section 10")
disp(T11-T10+" Section 11")
disp(T12-T11+" Section 12")
disp(T13-T12+" Section 13")
disp(T14-T13+" Section 14")
disp((T15_16)-T14+" Section 15/16")
disp(T17-(T15_16)+" Section 17")
disp(T18-T17+" Section 18")
disp(T19-T18+" Section 19")
disp(T20-T19+" Section 20")
disp(T21-T20+" Section 21")
disp(T22-T21+" Section 22")

total_energy = (Watthours_net-(Energy_left/3600))*8;
total_time = tnet*8;

minutes = 0;
while total_time-60 > 0
    minutes = minutes+1;
    total_time = total_time-60;
end
seconds = total_time;

disp(" ")
disp("total time: "+minutes+":"+seconds)
disp("Capacity left: "+(Watthours_net-total_energy)+" Wh")



