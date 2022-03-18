function energy_lost = getEnergyLost(Vref,Area,Drag_Coeff,mass,Ptire)
    Fair = 0.5*1.23*(Vref.^2)*Area*Drag_Coeff;
    c = 0.005+(1/Ptire)*(0.01+0.0095*(Vref*3.6/100).^2);
    Ffrict = c*mass*9.81;
    energy_lost = Vref*(Ffrict+Fair); %% in Watts
end

