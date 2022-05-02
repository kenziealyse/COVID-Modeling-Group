%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file is used for plotting p (I_l) versus days open. In the file
% we use defineParameters to randomly choose different parameters. We then
% run the the covid feedback solver for the randomly chosen variable and
% plot the days open versus p. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% CLEAR THE WORKSPACE

clear all;
close all;


% Fix Parameter Values

f  = 0.85;    % Fraction of true positives
B1 = 0.143;   % beta 1
B2 = 0.06;    % beta 2
b1 = 0.143;   % beta 1 tilde
b3 = 0.05;    % beta 3 tilde
B3 = 0.05;    % beta 3
gamma = 1/90; % gamma

params = [f, B1, B2, b1, b3, B3, gamma]; % vector of parameter values

% Boolean Values for Randomizing Parameters (1 to randomize)

B1b = 0;
B2b = 0;
b1b = 0;
b3b = 0;
B3b = 0;
low_vr = 0;
high_vr = 0;
vR_Ub = 0;
gammab = 1;

varstr = '$\gamma = $'; % Name of variable that is being randomized for the graph



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
vR_U_vec = (1.01);


% Prepicked Random Values

%vR_U_vec = [0.35199, 0.34693, 0.37507, 0.46477]; %low vr
% vR_U_vec = [1.2477, 1.356, 1.7578, 1.0144]; % high vr
% vR_U_vec = [0.62991, 0.5213, 0.51313, 1.776]; % all vr
% B1_vec = (0.143:0.01:0.224); % B1 vectors
% B2_vec = (0.053:0.001:0.085); %B2 vectors


% Preallocate Space 

days_open_vec = (1:length(I_L));
events_vec = (1:length(I_L));
pvals = [];
values5p = [];
infectionpeak = [];
legendInfo = [];
maxes = [];


for j = 1:4
    
    
    [f, B1, B2, b1, b3, B3, vR_U, gamma] = defineParameters(f, B1b, B2b...
    , b1b, b3b, B3b, low_vr, high_vr, vR_Ub, gammab);
    
    params = [f, B1, B2, b1, b3, B3, vR_U, gamma];

    % Run the Covid Feedback Solver for Various p values (I_L)
    
    for i = 1:length(I_L)
    
    
    [T, S, I1u, I1a, I2, R, vR, tR, days_open, days_closed, event_counter, closures] = covid_feedback_solver(t0, final_time, init_conds, params,...
    I_L(i), I_U, vR_L, vR_U, tR_L, tR_U, event_start);

    I = .99 - S(end);

    infectionpeak(i) = I;
    
    days_open_vec(i) = days_open - event_counter;
    
    events_vec(i) = event_counter;
    
    
    end
    

    % Plots I_L versus Days open for every random variable (p versus days
    % open)

    plot(I_L,days_open_vec, 'LineWidth',1.5);
    legendInfo{j} = [varstr num2str(gamma)];
    hold on  

% Find maximum number of days open
    
    % Find the maximum number of days open and the index where it occurs 
    
    [maximum, index] = max(days_open_vec);
    
    % Set the maximum to negative inf.
    
    days_open_vec(index) = -Inf; 
    
    % Find the p value that corresponds to that max
    
    maxes(j) = I_L(index); 

    % Find the indices of all values within 10 percent of the maximum

    indices = find(.9*maximum <= days_open_vec);


    % Store values within 10 percent of max into a vector

        for i = 1:length(indices)

            values5p = [values5p;days_open_vec(indices(i))]; 

            pvals = [pvals;I_L(indices(i))];


        end

end


% Add titles to I_L versus Days open Plot (plotted in loop)

xlabel('\bf $\tilde{p}$', 'Interpreter','latex', 'Fontsize',17)
ylabel('\bf Days (t_{open})', 'Fontsize',17)
legend(legendInfo, 'Location', 'best', 'Interpreter', 'Latex')
grid on


% Plot Histogram

figure(2)

[N,edges] = histcounts(pvals,3);


histogram(pvals,75)
title('\bf $\tilde{p}$ Values Resulting in Maximum Days Open','Interpreter','latex', 'FontSize', 20)
xlabel('\bf $\tilde{p}$ Value','Interpreter','latex', 'FontSize', 17)
ylabel('\bf Number of $\tilde{p}$ Value Occurences','Interpreter','latex', 'FontSize', 17)