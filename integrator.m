time = 0;
area = 0;
count = 1;
while time <= tnet
    area = area + tStep*current(count);
    count = count + 1;
    time = time + tStep;
end

disp(area)