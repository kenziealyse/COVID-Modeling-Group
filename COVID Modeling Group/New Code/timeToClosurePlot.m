
%CLEAR THE WORKSPACE

clear all;
clc
close all;

%TIME INTERVAL AND INITIAL CONDITIONS

tspan = [0 100];
init_cond = [0.99 .01 0 0 0]';


tR_values = 0:.001:1;

% Pre Allocate Space

time_tR = zeros(1,length(tR_values));

% Parameter Values

params = [.85, 0.143, 0.06, 0.143, 0.05, 0.05, 0];

for j = 1:length(tR_values)
    
        tR_fun = @(t, S, I1u) pulse_tR_fun(t,S, I1u, tR_values(j),7,0); %(t, S, testing rate, days_tested, delay after party)
        
        vR_params = [.3,.3,0,1]; % [vR_low,vR_high,t_on,t_off]

        vR_fun = @(t) pulse_vR_fun(t, vR_params,7,0); %(t,vR_params,party_days,single_event)

        [T, S, I1u, I1a, I2, R] = covidsolver(params, tR_fun, vR_fun, init_cond, tspan, 1, 0, 0, 0);
        
        time_tR(j) = T(end); 
        
end

vR_values = 0:.001:1;

% Pre Allocate Space

time_vR = zeros(1,length(vR_values));

for j = 1:length(vR_values)
    
        tR_fun = @(t, S, I1u) pulse_tR_fun(t,S, I1u, .1 ,1,0); %(t, S, testing rate, days_tested, delay after party)
        
        vR_params = [.22,vR_values(j),0,1]; % [vR_low,vR_high,t_on,t_off]

        vR_fun = @(t) pulse_vR_fun(t, vR_params,7,0); %(t,vR_params,party_days,single_event)
        
        [T, S, I1u, I1a, I2, R] = covidsolver(params, tR_fun, vR_fun, init_cond, tspan, 1, 0, 0, 0);
        
        time_vR(j) = T(end);
        
end

figure

yyaxis left
plot(known_peak_tR,tR_values,'-o','LineWidth',3);
title('Time to Closure (t_c)','FontSize',20)
xlabel('Days','FontSize',18)
ylabel('Weekly Testing Rate (v_r = .3)','FontSize',18)

axis([0 100 0 1]);

yyaxis right
plot(known_peak_vR,vR_values,'-o','LineWidth',3);
ylabel('Transmission Rate (T_r = .1)','FontSize',18)

hold on 

xline(90,'-.','linewidth',3)


legend('Testing Rate T_r', 'Transimission Rate v_r', '90 Day Semester');



