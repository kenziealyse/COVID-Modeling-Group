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

I_L = (0:.0001:.035); 
I_U = 0.05;
vR_L = 0;
tR_L = 0;
tR_U = 0.1;

% Run the solver

days_open_vec = (1:length(I_L));
events_vec = (1:length(I_L));


 pvals = [];
 values5p = [];

for j = 1:10
    
% Define Parameter Values
    
[f, B1, B2, b1, b3, B3, vR_U] = defineParameters(0.85, 0, 0, 0, 0, 0, 1);

params = [f, B1, B2, b1, b3, B3];

    
    for i = 1:length(I_L)
    
    
    [T, S, I1u, I1a, I2, R, vR, tR, days_open, days_closed, event_counter] = covid_feedback_solver(t0, final_time, init_conds, params,...
    I_L(i), I_U, vR_L, vR_U, tR_L, tR_U, event_start);

    days_open_vec(i) = days_open - event_counter;
    
    events_vec(i) = event_counter;
    
    end

    
[maximum, index] = max(days_open_vec);
days_open_vec(index)      = -Inf;
maxes(j) = I_L(index);

indices = find(.9*maximum <= days_open_vec);



for i = 1:length(indices)
    
    values5p = [values5p;days_open_vec(indices(i))]; 
    
    pvals = [pvals;I_L(indices(i))];
    
    
end



end

results(:,1) = pvals;

results(:,2) = values5p;

results



% Heat map plot

yaxisTitle = 'Change in B_1 Values';

%heatMapPlot(I_L, vR, days_open_vec, yaxisTitle)

% Feedback Plot 


%feedbackPlot(vR, I_L, I_U, I1a, I2, days_open_vec,...
    %events_vec, T)
    
% Plot Histogram

histogram(pvals, 200)

