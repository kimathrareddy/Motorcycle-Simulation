function anet = getAccel(Vin,Area,Drag_Coeff,mass,Ptire,Torque,wheel_radius)
    Fair = 0.5*1.23*(Vin.^2)*Area*Drag_Coeff;
    c = 0.005+(1/Ptire)*(0.01+0.0095*(Vin*3.6/100).^2);
    Ffrict = c*mass*9.81;
    Fmotor = Torque/wheel_radius;
    anet = (Fmotor-Fair-Ffrict)/mass;
end

