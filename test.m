current = energy*1.05/100.8;
number_parallel_batteries = 18;
number_series_batteries = 28;
resistance = 0.015; %in ohms
heat_loss = 0; %in watts using P = R*I^2

%account for heat loss
i = 1;
while i<length(current)
    heat_loss(i) = resistance*(current(i)/number_parallel_batteries)^2; %the total current/number of branches
    i = i+1;
end

heat_loss = heat_loss*number_parallel_batteries*number_series_batteries; %sum heat of each cell
heat_loss_kJ = sum(heat_loss)*tStep/1000; %total heat loss in kJ

disp("Average heat loss (W): "+ (sum(heat_loss)/length(heat_loss)));
disp("Max heat loss (W): "+ max(heat_loss));

disp("Total heat loss (kJ): "+ heat_loss_kJ);