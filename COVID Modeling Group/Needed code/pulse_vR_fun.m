%NEED TO CHANGE TO BE EVERY & DAYS IT TURNS ON
function vR = pulse_vR_fun(t, vR_low, vR_high, party_days, single_event)
% Step function to represent an increase in transmission rate between times
% t_on and t_off

check=max(t);
if single_event==1
    check=8;
end

if (mod(t,party_days) <= 1) && t>=party_days && t<=check
    
    vR = vR_high; % Time region where beta increases to beta_high
    
else
    
    vR = vR_low; % Else beta is at its lower value
end

end