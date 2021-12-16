% CLEAR THE WORKSPACE

clear all;
close all;


% Fix Parameter Values

f  = 0.85;
B1b = 0;
B2b = 0;
b1b = 0;
b3b = 0;
B3b = 0;  


% Fix Initial Conditions

t0 = 0;
final_time = 100;

init_conds = [0.99 .01 0 0 0]';

event_start = 1;

% Set upper and lower infected population bounds

I_L = .04; 
I_U = 0.05;
vR_L = 0;
tR_L = 0;
tR_U = 0.1;

% Run the solver

days_open_vec = (1:length(I_L));
events_vec = (1:length(I_L));


for j = 1:10
    
% Define Parameter Values
    
[f, B1, B2, b1, b3, B3, vR_U] = defineParameters(0.85, 0, 0, 0, 0, 0, 0);

params = [f, B1, B2, b1, b3, B3];

    
    for i = 1:length(I_L)
    
    
    [T, S, I1u, I1a, I2, R, vR, tR, days_open, days_closed, event_counter] = covid_feedback_solver(t0, final_time, init_conds, params,...
    I_L(i), I_U, vR_L, vR_U, tR_L, tR_U, event_start);

    days_open_vec(i) = days_open - event_counter;
    
    events_vec(i) = event_counter;
    
    end



end

% Calculuate Infected Population

I = I1a + I2;

% PLOT THE RESULTS

figure(2)

plot(T, 100*I, 'r', 'LineWidth',3);
hold on
plot(T, 100*vR, 'b', 'LineWidth',3);
hold on
yline(I_L*100, '--', 'lineWidth', 2);
hold on
yline(I_U*100, '--', 'lineWidth', 2);
legend('Total Infected','vR', 'FontSize',16);
ylabel('Percent of Population Infected', 'FontSize',17);
xlabel('Time (days)', 'FontSize',17);
title('COVID Feedback Plot', 'FontSize',20);
xlim([0 100])
ylim([0 45])
