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

% Boolean Values for Randomizing Parameters (1 to randomize)

B1b = 0;     %beta 1
B2b = 0;     %beta 2
b1b = 0;     %beta 1 tilde
b3b = 0;     %beta 3 tilde
B3b = 0;	 %beta 3
fb = 0;      %f
gammab = 0;   %gamma
low_vr = 0;  %low vr vector values
high_vr = 0; %high vr vector values
vR_Ub = 1;   % vr boolean expression

variable_names = {'$\beta_1 = $', '$\beta_2 = $', '$\tilde{beta_1} = $',...
    '$\tilde{beta_3} = $', '$\beta_3 = $', '$f = $', '$\gamma=$', '$v_r = $', '$v_r = $', ...
    '$v_r = $'}; %legend variable

filenames = {'beta1', 'beta2', 'beta1tilde',...
    'beta3tilde', 'beta3', 'f', 'gamma', 'lowvr', 'highvr', 'allvr'}; %name file

var1 = 7; %params = [f, B1, B2, b1, b3, B3, vR_U, gamma]

var2 = 10; %filename

iter = 4;


% Preallocate Space 

days_open_vec = (1:length(I_L));
events_vec = (1:length(I_L));
pvals = [];
values5p = [];
infectionpeak = [];
legendInfo = [];
maxes = [];


for j = 1:iter
    
    
    [f, B1, B2, b1, b3, B3, vR_U, gamma] = defineParameters(fb, B1b, B2b...
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
    legendInfo{j} = [variable_names{var2} num2str(params(var1))];
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

set(gcf, 'Units', 'Inches');
pos = get(gcf, 'Position');
set(gcf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)]);

figure_name = ['/WISA', filenames{var2}, 'pplot.pdf'];
    
dirPath = strcat('/','figures', figure_name); % Directory Path
    
saveas(gcf,[pwd dirPath]); % Save Figure in Folder