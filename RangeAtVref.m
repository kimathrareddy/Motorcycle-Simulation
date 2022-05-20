%Motorcycle Parameters
wheel_diameter = 0.4318; % in meters
wheel_radius = wheel_diameter/2;
gear_ratio = 2.1;
MotEff = 0.9;
mass = 202; %kg
Watthours_net = 9000;
Ptire = 200000; %in bar
Cross_Sect_Area = 0.8; %m^2. Approximated value for a rider in a casual riding position 
Drag_Coeff = 0.8; %Approximated value for a rider in a casual riding position 

%reference speed for simulation 
Vref = 89; %km/h
Vref = Vref/3.6; %in m/s

%simualtion parameters
dNet = 0; %in meters
dStepSize = 0.5; %meters
index = 1; 
Energy_left = Watthours_net*3600; %total energy in joules available

%-----EMRAX 208 motor start ------
rpm = 0:1:6000;
Array_limit = 6001;

Torque = zeros(1,6001); 
for n = 1:4000 %start filling torque values 0-4000rpm
    Torque(n) = 140;
end
for n = 4001:6001 %start filling torque values 4000-6000rpm
    Torque(n) = -0.01*(n*1)+180;
end

Power = zeros(1,6001); %already in kW
for n = 1:4000 %start filling power values 0-4000rpm
    Power(n) = 2+0.014*(n*1);
end
for n = 4001:6001 %start filling power values 4000-6000rpm
    Power(n) = 0.006*(n*1)+32;
end

%Account for gear ratio, already in N*m. This is the torque on the back
%wheel
for n = 1:6001
    Torque(n) = Torque(n)*gear_ratio;
end

%convert power into watts
for n = 1:6001
    Power(n) = Power(n)*1000;
end

%convert rpm to speed in m/s
speed = zeros(1,6001);
for n = 1:6001
    speed(n) = wheel_diameter*3.14*rpm(n)/(60*gear_ratio);
end

%-----EMRAX 208 motor end --------


%-----------MAIN CODE START-----
%-------------------------------

i = getIndexOfGraphValues(Vref,speed, Array_limit);
PowerCheck = Power(i);
energy_lost = getEnergyLost(Vref,Cross_Sect_Area,Drag_Coeff,mass,Ptire); 
if energy_lost > PowerCheck
    disp("The system cannot provide the needed power at "+Vref*3.6);
    
else

    while Energy_left >= 0 % while battery is filled
        energy_lost = getEnergyLost(Vref,Cross_Sect_Area,Drag_Coeff,mass,Ptire)*(dStepSize/Vref); %in Joules, W*d/v = J 
        Energy_left = Energy_left - energy_lost;
        dNet = dNet + dStepSize;
    end

end

disp(dNet/1000+" km")

%-----------MAIN CODE END-------
%-------------------------------
