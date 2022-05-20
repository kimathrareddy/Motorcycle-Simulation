plot(energy_location,torque_per_location)
hold on
title("Speed as a Function of Lap Distance");
xlabel("Lap position (m)");
ylabel("Speed (km/h)");
%show the section distances on the graph for clarity, starting with section 1
xline(108.64,'--r'); %section 1
xline(225.64,'--b'); %section 2
xline(296,'--r'); %section 3
xline(664,'--b'); %section 4
xline(761,'--r'); %section 5
xline(1183,'--b'); %section 6
xline(1234,'--r'); %section 7
xline(1351,'--b'); %section 8
xline(1404,'--r'); %section 9
xline(1749,'--b'); %section 10
xline(1813,'--r'); %section 11
xline(2039,'--b'); %section 12
xline(2109,'--r'); %section 13
xline(2157,'--b'); %section 14
xline(2452,'--r'); %section 15-16
xline(2679,'--b'); %section 17
xline(2746,'--r'); %section 18
xline(2814,'--b'); %section 19
xline(3027,'--r'); %section 20
xline(3138,'--b'); %section 21
xline(3942,'--r'); %section 22