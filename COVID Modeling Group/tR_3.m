function tR = tR_3(t, S, I1u, tR_high,days_tested,delay)
% Step function to represent an increase in testing rate between times
% t_on and t_off

tol = .001;

if (delay <= mod(t,days_tested)) && (mod(t,days_tested) <= delay + 1) ...
        && (S >= tol) && (I1u >= tol)
    
    tR = tR_high; % Time region where tR increases to tR_high
    
else
    
    tR = 0; % Else tR is at its lower value
end

if tR > (S+I1u)
    
    tR = S+I1u;
    
end



end