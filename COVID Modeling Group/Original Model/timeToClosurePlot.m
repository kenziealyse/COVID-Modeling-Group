%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file is used for plotting bar graph of the number of days open while
% varying Tr for a high and low vR value and varying vR for a high and low
% Tr value.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%CLEAR THE WORKSPACE

clear all;
clc
close all;

% Fix Parameter Values

f  = 0.85;   % Fraction of true positives
B1 = 0.143;  % beta 1
B2 = 0.06;   % beta 2
b1 = 0.143;  % beta 1 tilde
b3 = 0.05;   % beta 3 tilde
B3 = 0.05;   % beta 3

y = (0:.1:1); 

params = [f, B1, B2, b1, b3, B3]; % vector of parameter values

% Initial Conditions

tspan = [0 100];
init_cond = [0.99 .01 0 0 0]';
event = 1;
plotn = 0;

tR_values = 0:.1:1;

% Pre Allocate Space

time_tR1 = zeros(1,length(tR_values));
time_tR2 = zeros(1,length(tR_values));

% Set High vR Value

vR = 0.5;


for j = 1:length(tR_values)

        [T, S, I1u, I1a, I2, R] = covidSolver(params, tR_values(j), vR, init_cond, tspan, event, plotn);
        
        time_tR1(j) = T(end); 
        
end

% Set Low vR Value

vR = 0.3;

for j = 1:length(tR_values)

        [T, S, I1u, I1a, I2, R] = covidSolver(params, tR_values(j), vR, init_cond, tspan, event, plotn);
        
        time_tR2(j) = T(end); 
        
end

% Plot figure for varying tR

figure(1)

bar(y,time_tR2,'b')
hold on
bar(y,time_tR1, 'r')
hold on 
yline(90,'-.','linewidth',3)
hold off

title('Time to Closure (t_c)','FontSize',20)
xlabel('Transmission Rate (T_r)','FontSize',18)
ylabel('Time (days)','FontSize',18)
xticks([0:.1:1])
yticks([0:10:100])
legend('Low v_r Value (v_r = 0.3)', 'High v_r Value (v_r = 0.5)', '90 Day Semester',...
    'Location','best', 'fontsize', 17);


vR_values = 0:.1:1;

% Pre Allocate Space

time_vR1 = zeros(1,length(vR_values));
time_vR2 = zeros(1,length(vR_values));


% Set high tR Value

tR = 1;


for j = 1:length(vR_values)
   
            
        [T, ~, ~, ~, ~, ~] = covidSolver(params, tR, vR_values(j), init_cond, tspan, event, plotn);
        
        time_vR1(j) = T(end);
        
end

% Set Low tR Value

tR = 0.5;

for j = 1:length(vR_values)
    

        [T, S, I1u, I1a, I2, R] = covidSolver(params, tR, vR_values(j), init_cond, tspan, event, plotn);
        
        time_vR2(j) = T(end);
        
end

% Plot figure for varying vR

figure(2)

bar(y,time_vR1, 'r')
hold on
bar(y,time_vR2, 'b')
hold on 
yline(90,'-.','linewidth',3)
hold off

title('Time to Closure (t_c)','FontSize',20)
xlabel('Infection Rate (v_r)','FontSize',18)
ylabel('Time (days)','FontSize',18)
xticks([0:.1:1])
yticks([0:10:100])


legend('High T_r Value (T_r = 1)', 'Low T_r Value (T_r = 0.5)', '90 Day Semester',...
    'Location','best', 'fontsize', 17);


