%This is the max speed program

wheel_diameter = 0.4318; % in meters
wheel_radius = wheel_diameter/2;
gear_ratio = 2.3;
Vinit = 0;%in m/s
Vfinal = 0;
tStepSize = 0.0001; %seconds
acceleration = 0.1;
Cross_Sect_Area = 0.5; %m^2
Drag_Coeff = 0.88;
Ptire = 200000; %in bar
energy_lost = -1;
index = 1;
count = 0;
invalid_num = 0;

prompt = ['Hyper 9X1: 1\nAC-20 96V: 2\nAC-34 96V: 3\nAC-23 96V: 4\nEMRAX 208: 5\nEMRAX 188: 6\n'];
disp("enter number for the motor to use");
motor_choice = input(prompt);

if motor_choice == 1
%--- Hyper 9X1 motor start ------
% rpm to speed, is v(m/s) = (diameter(in meters)*pi)*rpm/(60sec*gear ratio) -----
rpm = 0:1:8000;
Array_limit = 8001;
mass = 247.4;

Torque = zeros(1,8001);
for n = 1:3000 %start filling torque values 0-3000rpm
    Torque(n) = 233;
end
for n = 3001:4500 %start filling torque values 3000-4500rpm
    Torque(n) = -0.0408*(n*1)+357.2;
end
for n = 4501:8001 %start filling torque values 4500-8000rpm
    Torque(n) = -0.03208*(n*1)+320.2;
end

Power = zeros(1,8001);
for n = 1:3300 %start filling power values 0-3300rpm
    Power(n) = 2+0.0242*(n*1);
end
for n = 3301:6000 %start filling power values 3000-6000rpm
    Power(n) = 81;
end
for n = 6000:8001 %start filling power values 6000-8000rpm
    Power(n) = -0.01375*(n*1)+162.85;
end

%account for gear ratio
for n = 1:8001
    Torque(n) = Torque(n)*gear_ratio;
end

%convert power into watts
for n = 1:8001
    Power(n) = Power(n)*1000;
end

%convert rpm to speed in m/s
speed = zeros(1,8001);
for n = 1:8001
    speed(n) = wheel_diameter*3.14*rpm(n)/(60*gear_ratio);
end

%-----Hyper 9X1 motor end --------

elseif motor_choice == 2
%-----AC-20 96V motor start ------
rpm = 0:1:8000;
Array_limit = 8001;
mass = 220;

Torque = zeros(1,8001);
for n = 1:4500 %start filling torque values 0-4500rpm
    Torque(n) = -0.00288*(n*1)+111.4;
end
for n = 4501:6000 %start filling torque values 4500-6000rpm
    Torque(n) = -0.0222*(n*1)+202.5;
end
for n = 6001:8000 %start filling torque values 6001-8000rpm
    Torque(n) = -0.0182*(n*1)+172.4;
end

Power = zeros(1,8001); %already in kW
for n = 1:5000 %start filling power values 0-5000rpm
    Power(n) = 2+0.009784*(n*1); 
end
for n = 5001:8000 %start filling power values 5001-8000rpm
    Power(n) = -0.0084*(n*1)+90.4;
end

%Account for gear ratio, already in N*m
for n = 1:8001
    Torque(n) = Torque(n)*gear_ratio;
end

%convert power into watts
for n = 1:8001
    Power(n) = Power(n)*1000;
end

%convert rpm to speed in m/s
speed = zeros(1,8001);
for n = 1:8001
    speed(n) = wheel_diameter*3.14*rpm(n)/(60*gear_ratio);
end
%-----AC-20 96V motor end --------

elseif motor_choice == 3
%-----AC-34 96V motor start --------
rpm = 0:1:8000;
Array_limit = 8001;
mass = 245;

Torque = zeros(1,8001); 
for n = 1:1000 %start filling torque values 0-1000rpm
    Torque(n) = -0.009*(n*1)+144;
end
for n = 1001:3500 %start filling torque values 1000-3500rpm
    Torque(n) = 135;
end
for n = 3501:5500 %start filling torque values 3500-5500rpm
    Torque(n) = -0.0375*(n*1)+266.25;
end
for n = 5501:8001 %start filling torque values 5500-8000rpm
    Torque(n) = -0.01488*(n*1)+141.84;
end

Power = zeros(1,8001); %already in kW
for n = 1:3500 %start filling power values 0-3500rpm
    Power(n) = 2+0.013909*(n*1);
end
for n = 3501:8001 %start filling power values 3500-8000rpm
    Power(n) = -0.0066178*(n*1)+71.8422;
end

%Account for gear ratio, already in N*m
for n = 1:8001
    Torque(n) = Torque(n)*gear_ratio;
end

%convert power into watts and account for losses 
for n = 1:8001
    Power(n) = Power(n)*1000;
end

%convert rpm to speed in m/s
speed = zeros(1,8001);
for n = 1:8001
    speed(n) = wheel_diameter*3.14*rpm(n)/(60*gear_ratio);
end
%-----AC-34 96V motor end --------

elseif motor_choice == 4
%-----AC-23 96V motor start --------
rpm = 0:1:8000;
Array_limit = 8001;
mass = 220;

Torque = zeros(1,8001); 
for n = 1:2500 %start filling torque values 0-2500rpm
    Torque(n) = -0.00712*(n*1)+173;
end
for n = 2501:5000 %start filling torque values 2500-5000rpm
    Torque(n) = -0.0384*(n*1)+251.2;
end
for n = 5001:8001 %start filling torque values 5000-8000rpm
    Torque(n) = -0.01413*(n*1)+128.7;
end

Power = zeros(1,8001); %already in kW
for n = 1:3200 %start filling power values 0-3200rpm
    Power(n) = 2+0.013184*(n*1);
end
for n = 3201:8001 %start filling power values 3200-8000rpm
    Power(n) = -0.0058792*(n*1)+61.0033;
end

%Account for gear ratio, already in N*m
for n = 1:8001
    Torque(n) = Torque(n)*gear_ratio;
end

%convert power into watts and account for losses 
for n = 1:8001
    Power(n) = Power(n)*1000;
end

%convert rpm to speed in m/s
speed = zeros(1,8001);
for n = 1:8001
    speed(n) = wheel_diameter*3.14*rpm(n)/(60*gear_ratio);
end

%-----AC-23 96V motor end --------

elseif motor_choice == 5

%-----EMRAX 208 motor start ------
MotEff = 0.90;
rpm = 0:1:6000;
Array_limit = 6001;
mass = 202; %kg

Torque = zeros(1,6001); 
for n = 1:4500 %start filling torque values 0-4500rpm
    Torque(n) = -0.00288*(n*1)+111.4;
end
for n = 4501:6000 %start filling torque values 4500-6000rpm
    Torque(n) = -0.0222*(n*1)+202.5;
end
for n = 6001:8000 %start filling torque values 6001-8000rpm
    Torque(n) = -0.0182*(n*1)+172.4;
end

Power = zeros(1,8001); %already in kW
for n = 1:5000 %start filling power values 0-5000rpm
    Power(n) = 2+0.009784*(n*1);
end
for n = 5001:8000 %start filling power values 5001-8000rpm
    Power(n) = -0.0084*(n*1)+90.4;
end

%Account for gear ratio, already in N*m
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

elseif motor_choice == 6
%-----EMRAX 188 motor start ------
MotEff = 0.90;
rpm = 0:1:6500;
Array_limit = 6501;
mass = 200; %kg

Torque = zeros(1,6001); 
for n = 1:5000 %start filling torque values 0-4000rpm
    Torque(n) = 90;
end
for n = 5001:6501 %start filling torque values 4000-6000rpm
    Torque(n) = -0.01*(n*1)+140;
end

Power = zeros(1,6501); %already in kW
for n = 1:5000 %start filling power values 0-5000rpm
    Power(n) = 2+0.0092*(n*1);
end
for n = 5001:6501 %start filling power values 5000-6500rpm
    Power(n) = 0.004*(n*1)+26;
end

%Account for gear ratio, already in N*m
for n = 1:6501
    Torque(n) = Torque(n)*gear_ratio;
end

%convert power into watts
for n = 1:6501
    Power(n) = Power(n)*1000;
end

%convert rpm to speed in m/s
speed = zeros(1,6501);
for n = 1:6501
    speed(n) = wheel_diameter*3.14*rpm(n)/(60*gear_ratio);
end

%-----EMRAX 188 motor end --------

else 
    invalid_num = 1;
end

%-----------MAIN CODE START-----
%-------------------------------
while invalid_num == 0 && acceleration > 0.01 && count ~= 100000*1000 && energy_lost < Power(index) %count is to get out of an infinite loop if acceleration is always > 0
    acceleration = getAccel(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire,Torque(index),wheel_radius);
    PowerCheck = Power(index);
    energy_lost = getEnergyLost(Vinit,Cross_Sect_Area,Drag_Coeff,mass,Ptire); 
    if energy_lost > PowerCheck
        disp("The system cannot provide the needed power at "+Vinit*3.6+" km/h");
        disp(PowerCheck+" "+energy_lost)
        break
    end
    Vfinal = getVfinal(acceleration,tStepSize,Vinit);
    Vinit = Vfinal;
    index = getIndexOfGraphValues(Vinit,speed, Array_limit);
    count = count +1;
    
end

if invalid_num == 1
    disp("invalid input")

elseif count == 100000*1000 
disp("Graph data is too small to find max speed")
disp("max speed available is "+speed(Array_limit)*3.6+" km/h")
disp("acceleration is "+acceleration)
disp("Current speed is "+Vinit*3.6+" km/h")
else
    disp(Vinit*3.6+" km/h max speed")
    disp("Acceleration is "+acceleration+" m/s^2")
    disp("Theoretical max speed is "+speed(Array_limit)*3.6+" km/h")
end
%-----------MAIN CODE END-------
%-------------------------------
