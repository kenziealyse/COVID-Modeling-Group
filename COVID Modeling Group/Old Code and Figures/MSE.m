
%CLEAR THE WORKSPACE

clear all;
clc
close all;

%TIME INTERVAL AND INITIAL CONDITIONS

tspan = [0 100];
init_cond = [0.99 .01 0 0 0]';


%% VECTOR FOR WEEKLY TESTING RATES %%

tR_values = 0:.001:1;

% Pre Allocate Space

time_tR = zeros(1,length(tR_values));

% Parameter Values

params = [.85, 0.143, 0.06, 0.143, 0.05, 0.05, 0];

for j = 1:length(tR_values)
    
        tR_fun = @(t, S, I1u) pulse_tR_fun(t,S, I1u, tR_values(j),7,0); %(t, S, testing rate, days_tested, delay after party)
        
        vR_params = [.3,.3,0,1]; % [vR_low,vR_high,t_on,t_off]

        vR_fun = @(t) pulse_vR_fun(t, vR_params,7,0); %(t,vR_params,party_days,single_event)

        [T, S, I1u, I1a, I2, R] = covidsolver(params, tR_fun, vR_fun, init_cond, tspan, 1, 0, 0, 0);
        
        time_tR(j) = T(end); 
        
end

%% VECTOR FOR WEEKLY TESTING RATES %%

vR_values = 0:.001:1;

% Pre Allocate Space

time_vR = zeros(1,length(vR_values));

for j = 1:length(vR_values)
    
        tR_fun = @(t, S, I1u) pulse_tR_fun(t,S, I1u, .1 ,1,0); %(t, S, testing rate, days_tested, delay after party)
        
        vR_params = [.22,vR_values(j),0,1]; % [vR_low,vR_high,t_on,t_off]

        vR_fun = @(t) pulse_vR_fun(t, vR_params,7,0); %(t,vR_params,party_days,single_event)
        
        [T, S, I1u, I1a, I2, R] = covidsolver(params, tR_fun, vR_fun, init_cond, tspan, 1, 0, 0, 0);
        
        time_vR(j) = T(end);
        
end

figure

yyaxis left
plot(known_peak_tR,tR_values,'-o','LineWidth',3);
title('Time to Closure (t_c)','FontSize',20)
xlabel('Days','FontSize',18)
ylabel('Weekly Testing Rate (v_r = .3)','FontSize',18)

axis([0 100 0 1]);

yyaxis right
plot(known_peak_vR,vR_values,'-o','LineWidth',3);
ylabel('Transmission Rate (T_r = .1)','FontSize',18)

hold on 

xline(90,'-.','linewidth',3)


legend('Testing Rate T_r', 'Transimission Rate v_r', '90 Day Semester');




%% VECTOR FOR vr1 = .5 LOW vr OF .22 %%

% Parameter Values

params = [.85, 0.143, 0.06, 0.143, 0.05, 0.05, 0];

% Various Testing Delays

delay_in_testing = 1:.01:7;

%Pre Allocate Space for Tc for vr1

Tc_vr1 = zeros(1,length(delay_in_testing));

for j = 1:length(delay_in_testing)
    
        tR_fun = @(t, S, I1u) pulse_tR_fun(t,S, I1u, .1,7,delay_in_testing(j)); %(t, S, testing rate, days_tested, delay after party)
        
        vR_params = [.22,.5,0,1]; % [vR_low,vR_high,t_on,t_off]

        vR_fun = @(t) pulse_vR_fun(t, vR_params,7,0); %(t,vR_params,party_days,single_event)
        
        [T, S, I1u, I1a, I2, R] = covidsolver(params, tR_fun, vR_fun, init_cond, tspan, 1, 0, 0 ,0);
        
        Tc_vr1(j) = T(end);
        
end

%% VECTOR FOR vr2 = 1 LOW vr OF .22 %%

%Pre Allocate Space for Tc for vr2

Tc_vr2 = zeros(1,length(delay_in_testing));

for j = 1:length(delay_in_testing)
    
        tR_fun = @(t, S, I1u) pulse_tR_fun(t,S, I1u, .1,7,delay_in_testing(j)); %(t, S, testing rate, days_tested, delay after party)
        
        vR_params = [.22,1,0,1]; % [vR_low,vR_high,t_on,t_off]

        vR_fun = @(t) pulse_vR_fun(t, vR_params,7,0); %(t,vR_params,party_days,single_event)
        
        [T, S, I1u, I1a, I2, R] = covidsolver(params, tR_fun, vR_fun, init_cond, tspan, 1, 0, 0, 0);
        
        Tc_vr2(j) = T(end);        
end

% PLOT VECTORS

figure

yyaxis left
plot(Tc_vr1,delay_in_testing,'-o','LineWidth',3);
title('Time to Closure (t_c)','FontSize',20)
xlabel('Days','FontSize',18)
ylabel('Days (Delay in Testing)','FontSize',18)

axis([0 100 1 7]);

yyaxis right
plot(Tc_vr2,delay_in_testing,'-o','LineWidth',3);
ylabel('Days (Delay in Testing)','FontSize',18)

hold on 

xline(90,'-.','linewidth',3)


legend('Testing Rate T_r', 'Transimission Rate v_r', '90 Day Semester');

Known Infection Peak When Incorperating Delays in Testing (MULTIPLE SPREADER EVENTS)


%% VECTOR FOR vr1 = .5 LOW vr OF .22 %%

% Parameter Values

params = [.85, 0.143, 0.06, 0.143, 0.05, 0.05, 0];

% Various Testing Delays

delay_in_testing = 1:.01:7;

%Pre Allocate Space for Tc for vr1

known_peak_vr1 = zeros(1,length(delay_in_testing));

for j = 1:length(delay_in_testing)
    
        tR_fun = @(t, S, I1u) pulse_tR_fun(t,S, I1u, .1,7,delay_in_testing(j)); %(t, S, testing rate, days_tested, delay after party)
        
        vR_params = [.22,.5,0,1]; % [vR_low,vR_high,t_on,t_off]

        vR_fun = @(t) pulse_vR_fun(t, vR_params,7,1); %(t,vR_params,party_days,single_event)
        
        [T, S, I1u, I1a, I2, R] = covidsolver(params, tR_fun, vR_fun, init_cond, tspan, 0, 0, 0 ,0);
        
        peak = I1a + I2;
        
        known_peak_vr1(j) = max(peak);
        
end

%% VECTOR FOR vr2 = 1 LOW vr OF .22 %%

%Pre Allocate Space for Tc for vr2

known_peak_vr2 = zeros(1,length(delay_in_testing));

for j = 1:length(delay_in_testing)
    
        tR_fun = @(t, S, I1u) pulse_tR_fun(t,S, I1u, .1,7,delay_in_testing(j)); %(t, S, testing rate, days_tested, delay after party)
        
        vR_params = [.22,1,0,1]; % [vR_low,vR_high,t_on,t_off]

        vR_fun = @(t) pulse_vR_fun(t, vR_params,7,1); %(t,vR_params,party_days,single_event)
        
        [T, S, I1u, I1a, I2, R] = covidsolver(params, tR_fun, vR_fun, init_cond, tspan, 0, 0, 0, 0);
        
        peak = I1a + I2;
        
        known_peak_vr2(j) = max(peak);        
end

% PLOT VECTORS


figure

yyaxis left
plot(known_peak_vr1,delay_in_testing,'-o','LineWidth',3);
title('Known Infection Peak','FontSize',20)
xlabel('Ratio of Infected to Total Population','FontSize',18)
ylabel('Days (Delay in Testing)','FontSize',18)

axis([0 1 1 7]);

yyaxis right
plot(known_peak_vr2,delay_in_testing,'-o','LineWidth',3);
ylabel('Days (Delay in Testing)','FontSize',18)

hold on

xline(.05,'-.','linewidth',3)


legend('Testing Rate T_r', 'Transimission Rate v_r', '5% Infected');
Time To Closure As A Heat Map (MULTIPLE SUPER SPREADING EVENTS)
% Various Testing Rates

Testing_rates = [.1,.2,.3,.4,.5,.6,.7,.8,.9,1];

% Various Infection Rates

VR_rates = [.1,.2,.3,.4,.5,.6,.7,.8,.9,1];

% Matrix to store peak I values

Tc_values = zeros(length(Testing_rates),length(VR_rates));

% Parameter Values

params = [.85, 0.143, 0.06, 0.143, 0.05, 0.05, 0]; %param values

% Nested for loop to run known infection peak for various vr and Tr values

for i = 1:length(Testing_rates)
          
    tR_fun = @(t, S, I1u) pulse_tR_fun(t,S, I1u, Testing_rates(i),7,0); %(t, S, testing rate, days_tested, delay after party)

    for j = 1:length(VR_rates)
        
        vR_params = [.22,VR_rates(j),0,1]; % [vR_low,vR_high,t_on,t_off]

        vR_fun = @(t) pulse_vR_fun(t, vR_params,7,0); %(t,vR_params,party_days,single_event)
        
        [T, S, I1u, I1a, I2, R] = covidsolver(params, tR_fun, vR_fun, init_cond, tspan, 1, 0, 0, 0);
        
        Tc_values(i, j) = T(end);
        
    end
end