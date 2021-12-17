% CLEAR THE WORKSPACE

clear all;
close all;

rng(42)


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

I_L = (0:.001:.035); 
I_U = 0.05;
vR_L = 0;
tR_L = 0;
tR_U = 0.1;

% Run the solver

days_open_vec = (1:length(I_L));
events_vec = (1:length(I_L));

% Create Empty Vectors 

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


plot(I_L,days_open_vec);
hold on    
    
[maximum, index] = max(days_open_vec);
days_open_vec(index)      = -Inf;
maxes(j) = I_L(index);

indices = find(.9*maximum <= days_open_vec);



for i = 1:length(indices)
    
    values5p = [values5p;days_open_vec(indices(i))]; 
    
    pvals = [pvals;I_L(indices(i))];
    
    
end



end

title('COVID Feedback Plot Days Open Versus P', 'Fontsize',20)
xlabel('P', 'Fontsize',17)
ylabel('Days', 'Fontsize',17)
grid on


% Calculuate Infected Population

I = I1a + I2;

% PLOT THE RESULTS

figure(2)

yline(I_L(end)*100, '--', 'lineWidth', 2);
hold on
yline(I_U*100, '--', 'lineWidth', 2);
hold on
plot(T, 100*I, 'r', 'LineWidth',3);
hold on
plot(T, 100*vR, 'b', 'LineWidth',3);
legend('Total Infected','vR', 'FontSize',16);
ylabel('Percent of Population Infected', 'FontSize',17);
xlabel('Time (days)', 'FontSize',17);
title('Covid Feedback Plot', 'FontSize',20);
xlim([0 100])
ylim([0 45])

    
% Plot Histogram

figure(3)


[N,edges] = histcounts(pvals,3);


histogram(pvals,3)
title('P Values Resulting in Maximum Days Open', 'FontSize', 20)
xlabel('Number of P Value Occurence', 'FontSize', 17)
ylabel('P Value', 'FontSize', 17)


for i = 1:length(pvals)
    
if (edges(1) <= pvals(i)) && (pvals(i) <= edges(2))
    
    pval1(i,1) = pvals(i);
    
end


if (edges(2) <= pvals(i)) && (pvals(i) <= edges(3))
    
    pval2(i,1) = pvals(i);
    
end

if (edges(3) <= pvals(i)) && (pvals(i) <= edges(4))
    
    pval3(i,1) = pvals(i);
    
end


end


pval1 = nonzeros(pval1)
pval2 = nonzeros(pval2)
pval3 = nonzeros(pval3)

var(pval1)
var(pval2)
var(pval3)
