%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file is used for plotting p (I_l) versus days open. In the file
% we use defineParameters to randomly choose different parameters. We then
% run the the covid feedback solver for the randomly chosen variable and
% plot the days open versus p. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [days_open_vec, I_L, pvals] = generate_data(B1b, B2b, b1b, b3b, B3b, ...
    fb, low_vr, high_vr, vR_Ub, varstr, var1, iter)

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


% Preallocate Space 

days_open_vec = (1:length(I_L));
events_vec = (1:length(I_L));
pvals = [];
values5p = [];
infectionpeak = [];
legendInfo = [];
maxes = [];


for j = 1:iter
    
    
    [f, B1, B2, b1, b3, B3, vR_U] = defineParameters(fb, B1b, B2b...
    , b1b, b3b, B3b, low_vr, high_vr, vR_Ub);

    params = [f, B1, B2, b1, b3, B3, vR_U];

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
    legendInfo{j} = [varstr num2str(params(var1))];
    hold on  

% Find maximum number of days open
    % Find the maximum number of days open and the index where it occurs 
    [maximum, index] = max(days_open_vec);
    
    % Set the maximum to negative inf.
%     days_open_vec(index) = -Inf; 
    
    % Find the p value that corresponds to that max
    maxes(j) = I_L(index); 

    % Find the indices of all values within 5 percent of the maximum
    indices = find(.95*maximum <= days_open_vec);

    % Store values within 10 percent of max into a vector
        for i = 1:length(indices)
            values5p = [values5p;days_open_vec(indices(i))]; 
            pvals = [pvals;I_L(indices(i))];
        end

end


% Add titles to I_L versus Days open Plot (plotted in loop)

xlabel('\bf $\tilde{p}$', 'Interpreter','latex', 'Fontsize',17)
ylabel('\bf Days (t_{open})', 'Fontsize',17)
legend(legendInfo, 'Location', 'best', 'Interpreter','latex')
grid on