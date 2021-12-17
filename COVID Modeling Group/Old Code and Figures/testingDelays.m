% Fix Parameter Values

f  = 0.85;
B1 = 0.143;
B2 = 0.06;
b1 = 0.143;
b3 = 0.05;
B3 = 0.05;  


params = [f, B1, B2, b1, b3, B3];

%Initial Conditions

init_cond = [0.99 .01 0 0 0]';

tspan = [0 200];

% Various Testing Delays

delay_in_testing = 0:1:6;

% vR Values

vR_params = [.22,.7,0,1]; % [vR_low,vR_high,t_on,t_off]

vR_fun = @(t) pulse_vR_fun(t, vR_params,7,0); %(t,vR_params,party_days,single_event)

for j = 1:length(delay_in_testing)
    
        tR_fun = @(t, S, I1u) pulse_tR_fun(t,S, I1u, .1,7,delay_in_testing(j)); 
        %(t, S, I1u, testing rate, days_tested, delay after party)
        
        [T, S, I1u, I1a, I2, R] = covidsolver(params, tR_fun, vR_fun, init_cond, tspan, 0, 0, 0);
        
        peak = (I1a + I2)*100;
        
        plot(T, peak, 'linewidth', 1, 'LineStyle',"-")
        
        hold on
        
end


yline(5, 'lineWidth', 3, 'lineStyle', ' --', 'color', 'r')
xline(90, 'lineWidth', 3, 'lineStyle', ' --', 'color', 'black')

legend('No Delay', '1 day', '2 days', '3 days', '4 days', '5 days', '6 days',...
    '5% Infected', '90 Day Semester')

title('Infection Peak When Varying Testing Delay', 'FontSize', 20)
xlabel('Time (days)','FontSize', 17)
ylabel('Percent of Population Infected (I_1^a + I_2)','FontSize', 17)
ylim([0 30])


hold off
