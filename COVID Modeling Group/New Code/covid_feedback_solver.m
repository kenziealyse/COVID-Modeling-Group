function [T, S_total, I1u_total, I1a_total, I2_total, R_total, vR, tR, days_open, days_closed, event_counter] = covid_feedback_solver(t0, final_time, init_conds, params,...
    I_L, I_U, vR_L, vR_U, tR_L, tR_U, event_start)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Inputs:
%
%   t0 - initial time
%   tf - final time
%   init_conds- initial conditions
%   params - fixed parameter values
%   I_lowerBound - Lower Bound of Infections
%   I_upperbound - Upper Bound of Infections
%   event_start - whether or not we are starting lockdown (0) or not
%   lockdown (1)
%
%Outputs:
%
%
%
%
%
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

days_open = 0;

days_closed = 0;

event_counter = 0;

current_time = t0;

current_event = event_start;

current_init_conds = init_conds;

% Create Vectors to store Solutions

T = [];
S_total = [];
I1u_total = [];
I1a_total = [];
I2_total = [];
R_total = [];
vR = [];
tR = [];


% Begin while loop that will switch between shut down event and open event


while current_time < final_time
    
    tspan = [current_time final_time]; % create the time span
    
    options = odeset('RelTol', 1e-8, ...
        'Events', @(t,y)Event(t, y, I_L, I_U, current_event)); % Create the Event function
    
    [T_curr,Y] = ode45(@(t,Y)covid(t, Y, params, vR_L, vR_U, tR_L, tR_U, current_event), tspan, current_init_conds, options); 
    
    % run the simulations with the event function
    
    % Save new values
    
    S_total = [S_total; Y(1:end-1,1)];
    I1u_total = [I1u_total; Y(1:end-1,2)];
    I1a_total = [I1a_total; Y(1:end-1,3)];
    I2_total = [I2_total; Y(1:end-1,4)];
    R_total = [R_total; Y(1:end-1,5)];
    T = [T; T_curr(1:end-1)];
    
    % Update vR and tR
    
    temp_time_start = fix(T_curr(1));
    
    temp_time_end = fix(T_curr(end));

    if current_event == 0
        vR_temp = vR_L*ones(length(T_curr)-1,1);
        tR_temp = tR_L*ones(length(T_curr)-1,1);
        days_closed = days_closed + (temp_time_end - temp_time_start);
    else
        vR_temp = vR_U*ones(length(T_curr)-1,1);
        tR_temp = tR_U*ones(length(T_curr)-1,1);
        days_open = days_open + (temp_time_end - temp_time_start);
        event_counter = event_counter + 1;
    end
    
    vR = [vR ; vR_temp];
    tR = [tR; tR_temp];
    
    % If the final time is hit, break out of loop
    
    current_time = T(end); % set new current time
    
    if abs(current_time - final_time) < 1
        break;
    end
    
    % Set the new initial conditions
    
    current_init_conds = [Y(end,1); Y(end,2); Y(end,3); Y(end,4);Y(end,5)];
    
    % A switch occurred, so reverse them ( will change current event
    % between 0 and 1)
    
    current_event = 1 - current_event;
    
    
end
    
% The event function

function [value,isterminal,direction] = Event(~, Y, I_L, I_U, current_event)

if current_event == 0
    I_crit = I_L;
else
    I_crit = I_U;
end

value = Y(3) + Y(4) - I_crit;  % Checks to see if the entire infected population is greater than I_crit
isterminal = 1; % If it is, terminate the simulation
direction = 0;

end


% Function to solve the ODE

function dY_dt = covid(~, Y, param, vR_L, vR_U, tR_L, tR_U, current_event)

%Unpack Parameters

f  = param(1);
B1 = param(2);
B2 = param(3);
b1 = param(4);
b3 = param(5);
B3 = param(6);    


% Relabel to easily keep track of compartments
S = Y(1);
I1u = Y(2);
I1a = Y(3);
I2 = Y(4);
R = Y(5);

% Control of social distancing

if current_event == 0
    vR_eval = vR_L;
    tR_eval = tR_L;
else
    vR_eval = vR_U;
    tR_eval = tR_U;
end


dS_dt   = -vR_eval*S*I1u/(S + I1u); %eq (1)
dI1u_dt =  vR_eval*S*I1u/(S + I1u) - (tR_eval*f*(I1u/(S + I1u))) - (B1+B3)*I1u;  %eq (2)
dI1a_dt =  tR_eval*f*(I1u/(S + I1u)) - (b1+b3)*I1a;  %eq (3)
dI2_dt  =  B1*I1u + b1*I1a - B2*I2;  %eq (4)
dR_dt   =  B2*I2 + B3*I1u + b3*I1a;  %eq (5)

dY_dt = [dS_dt; dI1u_dt; dI1a_dt; dI2_dt; dR_dt];

end


end
    