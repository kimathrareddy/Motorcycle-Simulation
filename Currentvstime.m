plot(energy_time,(energy*1.05/100.8))
hold on
title("Current as a Function of Time");
xlabel("Time (s)");
ylabel("Current Used (A)");
Q = trapz(energy_time,(energy*1.05/100.8));
disp("capacity (Ah): "+ (Q));
