%%%%%%%%%Motorcycle Parameters
global wheel_diameter 
wheel_diameter = 0.4318; % in meters

global wheel_radius 
wheel_radius = wheel_diameter/2;

gear_ratio = 2.1;

global c
c = 1.2; %coefficient of friction on tires in corners

global Cross_Sect_Area
Cross_Sect_Area = 0.5; %m^2

global Drag_Coeff
Drag_Coeff = 0.6;

global Ptire
Ptire = 200000; %in bar

global decelerate 
decelerate = -9.81*1; %in m/s, the max rate that drivers can slow down at

Watthours_net = 7776; %assuming worst case scenario of 2.7V in cell. Best case is 9216Whr with 3.2V in cell
Energy_left = Watthours_net*(3600/1000); %total energy in kJ available

global mass
mass = 202; %kg

%%%%%%%%%Simulation Variables
global energy_count %counter for array 
energy_count = 1;

global energy %energy array for graph
energy = 0;

global energy_location %position of energy use for graph
energy_location = 0;

global torque_per_location %used for finding current
torque_per_location = 0;

Vinit = 0; %in m/s

acceleration = 0; %in m/s^2

global speed_graph %used to plot the speed throughout the race
speed_graph = 0;

global tnet
tnet = 0;

global d_step
d_step = 0.40; %meters

global tStep
tStep = 0.001; %in seconds

global d_brake
d_brake = 0.1; %in meters, the amount of distance that you brake

global index
index = 1;

global energy_time
energy_time = 0;

%--- EMRAX 208 motor start ------
global MotEff
MotEff = 0.90;

rpm = 0:1:6000;

global Array_limit 
Array_limit = 6001;

global Torque
Torque = zeros(1,6001); 
for n = 1:4000 %start filling torque values 0-4000rpm
    Torque(n) = 70;
end
for n = 4001:6001 %start filling torque values 4000-6000rpm
    Torque(n) = -0.005*(n*1)+85;
end

global Power 
Power = zeros(1,6001); %already in kW
for n = 1:5000 %start filling power values 0-5000rpm
    Power(n) = 2+0.0068*(n*1);
end
for n = 5001:6001 %start filling power values 4000-6000rpm
    Power(n) = 0.002*(n*1)+24;
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
global speed
speed = zeros(1,6001);
for n = 1:6001
    speed(n) = wheel_diameter*3.14*rpm(n)/(60*gear_ratio);
end
%-----EMRAX 208 motor end --------



%-----Main code start ------------

%Section 1
radius = 75; %in meters
angle = 83; % in degrees
Vinit_last_section = curvedSection(Vinit,radius,angle);
T1 = tnet;

% Section 2
track_length = 117;
radius_next_section = 67; %in meters
Vinit_last_section = straightSection(Vinit_last_section,radius_next_section,track_length, 2);
T2 = tnet;

%Section 3
radius = 67; %in meters
angle = 61; % in degrees
Vinit_last_section = curvedSection(Vinit_last_section,radius,angle);
T3 = tnet;

% Section 4
track_length = 368;
radius_next_section = 74; %in meters
Vinit_last_section = straightSection(Vinit_last_section,radius_next_section,track_length, 4);
T4 = tnet;

%Section 5
radius = 74; %in meters
angle = 75; % in degrees
Vinit_last_section = curvedSection(Vinit_last_section,radius,angle);
T5 = tnet;

% Section 6
track_length = 422;
radius_next_section = 58; %in meters
Vinit_last_section = straightSection(Vinit_last_section,radius_next_section,track_length, 6);
T6 = tnet;

%Section 7
radius = 58; %in meters
angle = 50; % in degrees
Vinit_last_section = curvedSection(Vinit_last_section,radius,angle);
T7 = tnet;

% Section 8
track_length = 117;
radius_next_section = 54; %in meters
Vinit_last_section = straightSection(Vinit_last_section,radius_next_section,track_length, 8);
T8 = tnet;

%Section 9
radius = 54; %in meters
angle = 56; % in degrees
Vinit_last_section = curvedSection(Vinit_last_section,radius,angle);
T9 = tnet;

% Section 10
track_length = 345;
radius_next_section = 49; %in meters
Vinit_last_section = straightSection(Vinit_last_section,radius_next_section,track_length, 10);
T10 = tnet;

%Section 11
radius = 49; %in meters
angle = 79; % in degrees
Vinit_last_section = curvedSection(Vinit_last_section,radius,angle);
T11 = tnet;

% Section 12
track_length = 226;
radius_next_section = 45; %in meters
Vinit_last_section = straightSection(Vinit_last_section,radius_next_section,track_length, 12);
T12 = tnet;

%Section 13
radius = 45; %in meters
angle = 89; % in degrees
Vinit_last_section = curvedSection(Vinit_last_section,radius,angle);
T13 = tnet;

% Section 14
track_length = 48;
radius_next_section = 94; %in meters
Vinit_last_section = straightSection(Vinit_last_section,radius_next_section,track_length, 14);
T14 = tnet;

%Section 15 and 16 (combined them)
radius = 94; %in meters
angle = 180; % in degrees
radius_next_section = 74; %in meters
Vinit_last_section = hybridSection(Vinit_last_section,radius_next_section,radius,angle,15);
T15_16 = tnet;

%Section 17
radius = 74; %in meters
angle = 176; % in degrees
Vinit_last_section = curvedSection(Vinit_last_section,radius,angle);
T17 = tnet;

% Section 18
track_length = 67;
radius_next_section = 60; %in meters
Vinit_last_section = straightSection(Vinit_last_section,radius_next_section,track_length, 18);
T18 = tnet;

%Section 19
radius = 60; %in meters
angle = 65; % in degrees
Vinit_last_section = curvedSection(Vinit_last_section,radius,angle);
T19 = tnet;

% Section 20
track_length = 213;
radius_next_section = 83; %in meters
Vinit_last_section = straightSection(Vinit_last_section,radius_next_section,track_length, 20);
T20 = tnet;

%Section 21
radius = 83; %in meters
angle = 76; % in degrees
Vinit_last_section = curvedSection(Vinit_last_section,radius,angle);
T21 = tnet;

% Section 22
track_length = 804.6;
radius_next_section = 75; %in meters
Vinit_last_section = straightSection(Vinit_last_section,radius_next_section,track_length, 22);
T22 = tnet;

%adjust graph array to plot later
speed_graph(length(speed_graph)+1) = 0; %make the two array's equal because energy_location has one term extra 
energy(length(energy)+1) = 0; %make the two array's equal because energy_location has one term extra 

%display data
tnet_clone = tnet;
minutes = 0;
while tnet_clone-60 > 0
    minutes = minutes+1;
    tnet_clone = tnet_clone-60;
end
seconds = tnet_clone;

disp("Time to complete lap (mm:s) is: "+minutes+":"+seconds)
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

%calculate heat generation in battery
current =  torque_per_location/(0.19*gear_ratio); %divide by gear ratio to get motor torque (not wheel torque) as that dictates current
torque_per_location(length(torque_per_location)+1) = 1; %to make arrays equal
current(length(current)+1) = 1; %to make arrays equal
disp("nominal current draw (A): "+ sum(current)/length(current));
number_parallel_batteries = 6;
number_series_batteries = 32;
resistance = 0.004; %in ohms
heat_generation_Battery = zeros(length(current),1); %in watts using P = R*I^2
heat_generation_Battery(length(current)+1) = 1; %to make arrays equal
i = 1;
while i<=length(current)
    heat_generation_Battery(i) = resistance*(current(i)/number_parallel_batteries)^2; %the total current/number of branches
    i = i+1;
end

heat_generation_Battery = heat_generation_Battery*number_parallel_batteries*number_series_batteries; %sum heat of each cell
heat_generation_Battery_KJ = sum(heat_generation_Battery)*tStep/1000; %total heat loss in kJ

%account for heat loss of controller
Q_controller = 1800; %in W, from the emDrive Manual (assume average)
heat_generation_kJ_controller = tnet*Q_controller/1000;

average_battery_heat_loss = (sum(heat_generation_Battery)/length(heat_generation_Battery));
disp("Average heat generated from battery in a lap (W): "+ average_battery_heat_loss);
disp("Max heat generated from battery in a lap (W): "+ max(heat_generation_Battery));
disp("Total heat generated from battery in a lap (kJ): "+ heat_generation_Battery_KJ);
disp(" ")

%account for heat loss of motor
i = 1;
average_voltage = 100.8;
motor_heat_generation = zeros(length(current),1);

while i<=length(current)
    motor_heat_generation(i) = (1-MotEff)*current(i)*average_voltage; %P_elec = I*V, P_elec*(1-efficency) = Q
    i = i+1;
end

average_motor_heat_generation = sum(motor_heat_generation)/length(motor_heat_generation);
motor_heat_generation_kJ = sum(motor_heat_generation)*tStep/1000; %total heat loss in kJ

disp("Average heat generated from motor in a lap (W): "+ average_motor_heat_generation);
disp("Max heat generated from motor in a lap (W): "+ (1-MotEff)*max(current)*average_voltage);
disp("Total heat generated from motor in a lap (kJ): "+ motor_heat_generation_kJ);
disp(" ")

%energy from system in a lap
energy_used_per_lap = (sum(energy)*tStep/1000)/MotEff + heat_generation_Battery_KJ + heat_generation_kJ_controller; %MotEff for motor efficiency
disp("Energy used (KJ) from electrical system in a lap: "+energy_used_per_lap);

%amount of heat produced 
disp("Total amount of heat generated in a lap (kJ): " + (motor_heat_generation_kJ + heat_generation_Battery_KJ+heat_generation_kJ_controller))
disp("Average total amount of heat generated in a lap (W): " + (average_motor_heat_generation + average_battery_heat_loss + Q_controller))
disp(" ")

%energy percentage left after 1 lap
disp("Energy left (fraction) after 1 lap: "+(1-(energy_used_per_lap/Energy_left)));
disp(" ")

%average battery power needed
disp("Average battery power needed (W): "+ (((sum(energy)/length(energy)))+(sum(heat_generation_Battery)/length(heat_generation_Battery))+average_motor_heat_generation+Q_controller));
disp(" ")




