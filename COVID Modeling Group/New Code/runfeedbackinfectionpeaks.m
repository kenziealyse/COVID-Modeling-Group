% CLEAR THE WORKSPACE

clear all;
close all;


% Fix Parameter Values

f  = 0.85;
% B1 = 0.143;
B2 = 0.06;
b1 = 0.143;
b3 = 0.05;
B3 = 0.05; 

% params = [f, B1, B2, b1, b3, B3];


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

% vR_U_vec = [0.35199, 0.34693, 0.37507, 0.46477]; %low vr

% vR_U_vec = [1.2477, 1.356, 1.7578, 1.0144]; % high vr


% vR_U_vec = [0.62991, 0.5213, 0.51313, 1.776]; % all vr

B1_vec = (0.143:0.01:0.224); % B1 vectors

% Set Vectors 

% Run the solver

days_open_vec = (1:length(I_L));
events_vec = (1:length(I_L));

B2_vec = (0.053:0.001:0.085);

% Create Empty Vectors 

pvals = [];
values5p = [];

for j = 1:10
    
%     vR_U = vR_U_vec(j);

    vR_U = .5;
    
%     b2_start = B2_vec(1);
%     b2_end = B2_vec(end);
%     B2 = (b2_end-b2_start).*rand(1) + b2_start;
%     
%     
    b1_start = B1_vec(1);
    b1_end = B1_vec(end);
    B1 = (b1_end-b1_start).*rand(1) + b1_start;
   

    params = [f, B1, B2, b1, b3, B3];
    
    for i = 1:length(I_L)
    
    
    [T, S, I1u, I1a, I2, R, vR, tR, days_open, days_closed, event_counter, closures] = covid_feedback_solver(t0, final_time, init_conds, params,...
    I_L(i), I_U, vR_L, vR_U, tR_L, tR_U, event_start);

    I = .99 - S(end);

    infectionpeak(i) = I;
    
    days_open_vec(i) = days_open - event_counter;
    
    events_vec(i) = event_counter;
    
    
    end

% % Plots I_L versus infection peak for every random variable
% 
% 
% plot(I_L,infectionpeak*100, 'LineWidth',1.5);
% legendInfo{j} = ['vR = ' num2str(vR_U)];
% hold on    


% Plots I_L versus Days open for every random variable
    
plot(I_L,days_open_vec, 'LineWidth',1.5);
legendInfo{j} = ['\beta_1 = ' num2str(B1)];
hold on  


% Find maximum number of days open

[maximum, index] = max(days_open_vec);
days_open_vec(index)      = -Inf;
maxes(j) = I_L(index);

% Find the indices of all values within 10 percent of the maximum

indices = find(.9*maximum <= days_open_vec);


% Store values within 10 percent of max into a vector

for i = 1:length(indices)
    
    values5p = [values5p;days_open_vec(indices(i))]; 
    
    pvals = [pvals;I_L(indices(i))];
    
    
end





end

% % Add titles to I_L versus percent of population infected Plot
% 
% title('Percent of Population Infected Versus P', 'Fontsize',20)
% xlabel('P', 'Fontsize',17)
% ylabel('Percent of Population Infected', 'Fontsize',17)
% ylim([0 100])
% %legend(legendInfo)
% grid on

% Add titles to I_L versus Days open Plot
xlabel('\bf $\tilde{p}$', 'Interpreter','latex', 'Fontsize',17)
ylabel('\bf Days (t_{open})', 'Fontsize',17)
legend(legendInfo, 'Location', 'best')
grid on


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

    
% Plot Histogram

figure(3)


[N,edges] = histcounts(pvals,3);


histogram(pvals,75)
title('\bf $\tilde{p}$ Values Resulting in Maximum Days Open','Interpreter','latex', 'FontSize', 20)
xlabel('\bf $\tilde{p}$ Value','Interpreter','latex', 'FontSize', 17)
ylabel('\bf Number of $\tilde{p}$ Value Occurences','Interpreter','latex', 'FontSize', 17)


% Find the p values within each bin

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