%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File is used to plot a feedback plot. The idea is to shut down when the 
% infected population reaches a certain prespecified infected population 
% (the upper bound). When the shutdown occurs, the lower bounds for tR and 
% vR are used in order to mimic a lockdown. Then, when the infected
% population reaches the lower bound specified there is a reopening and tR
% and vR go back to their upper bound values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% CLEAR THE WORKSPACE

clear all;
close all;

% Fix Parameter Values

f  = 0.85;   % Fraction of true positives
B1 = 0.143;  % beta 1
B2 = 0.06;   % beta 2
b1 = 0.143;  % beta 1 tilde
b3 = 0.05;   % beta 3 tilde
B3 = 0.05;   % beta 3

params = [f, B1, B2, b1, b3, B3]; % parameter vector

% Fix Initial Conditions

t0 = 0;
final_time = 100;

init_conds = [0.99 .01 0 0 0]';

event_start = 1;

% Set upper and lower infected population bounds

I_L = .002; % lower bound for infected population 
I_U = 0.05; % upper bound for infected population 
vR_L = 0;   % lower bound for infected rate (vR)
vR_U = .5;  % upper bound for infected rate (vR)
tR_L = 0;   % lower bound for testing rate (tR)
tR_U = 0.1; % upper bound for testing rate (tR)

% Preallocate vector space

days_open_vec = (1:length(I_L)); % vector to keep track of the number of days open
events_vec = (1:length(I_L));    % vector to keep track of the number of events that occur

% Run the solver

[T, S, I1u, I1a, I2, R, vR, tR, days_open, days_closed, event_counter, closures] = covid_feedback_solver(t0, final_time, init_conds, params,...
I_L, I_U, vR_L, vR_U, tR_L, tR_U, event_start);

% Calculations

num_of_days_open = days_open - event_counter; % number of total days open

avg_days_open = num_of_days_open/event_counter; % average number of days open

avg_days_closed = days_closed/closures; % average number of days closed


% Put number of days open, average number of days open, and average number
% of days closed into table

Table = table(num_of_days_open, closures, avg_days_open, avg_days_closed) 


% Calculuate Infected Population

I = I1a + I2;


% PLOT THE RESULTS

figure(2)

fig = figure(2);

left_color = [1 0 0];
right_color = [0 0 1];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);

yyaxis right
plot(T, 100*vR, 'b', 'LineWidth',3);
ylabel('\bf $100*v_r$', 'Interpreter','latex', 'FontSize',17);

yyaxis left
plot(T, 100*I, 'r', 'LineWidth',3);
hold on
yline(I_U*100, '--', 'lineWidth', 2);
hold on
yline(I_L(end)*100, '--', 'lineWidth', 2, 'Color', 'green');
ylabel('\bf Percent of Population Infected', 'FontSize',17);



legend('Total Infected', 'p', '$\tilde{p}$','$v_r$','Interpreter','latex','FontSize',16, 'Location', 'best','Interpreter','latex');
xlabel('\bf Time (days)', 'FontSize',17);
title('\bf Covid Feedback Plot', 'FontSize',20);
xlim([0 100])

