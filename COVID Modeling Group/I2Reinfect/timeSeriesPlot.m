%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file is used for plotting a time series plot of each compartment 
% of the ODE versus time. Here, we use covidSolver and plotfxn.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Fix Parameter Values

f  = 0.85;   % Fraction of true positives
B1 = 0.143;  % beta 1
B2 = 0.06;   % beta 2
b1 = 0.143;  % beta 1 tilde
b3 = 0.05;   % beta 3 tilde
B3 = 0.05;   % beta 3

params = [f, B1, B2, b1, b3, B3]; % vector of parameter values

% Fix Initial Conditions

tspan = [0 100];
init_cond = [0.99 .01 0 0 0]';
event = 0;
plotn = 1 ;

% Plot for R0 < 1

tR = 0.4;    % testing rate (tr)
vR = 0.5;    % infection rate (vr)

covidSolver(params, tR, vR, init_cond, tspan, event, plotn);

% Plot for R0 > 1

tR = 0.2;   % testing rate (tr)
vR = 0.45;  % infection rate (vr)

covidSolver(params, tR, vR, init_cond, tspan, event, plotn);
