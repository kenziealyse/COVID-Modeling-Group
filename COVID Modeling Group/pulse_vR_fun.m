
function vR = pulse_vR_fun(t, vR_params, party_days, single_event)
% Step function to represent an increase in transmission rate between times
% t_on and t_off

vR_low = vR_params(1);
vR_high = vR_params(2);
t_on = vR_params(3);
t_off = vR_params(4);
% 
if single_event == 1

    if t > t_on && t <= t_off

        vR = vR_high; % Time region where vR increases to vR_high

    else

        vR = vR_low; % Else vR is at its lower value
    end

else
    
    if mod(t,party_days) <= 1
    
    vR = vR_high; % Time region where vR increases to vR_high
    
else
    
    vR = vR_low; % Else vR is at its lower value
    end

end

    

end