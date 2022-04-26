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

function [T, S, I1u, I1a, I2, R] = covidSolver(param, tR, vR, init_cond, tspan, event, plotn)

       f  = param(1);
       B1 = param(2);
       B2 = param(3);
       b1 = param(4);
       b3 = param(5);
       B3 = param(6); 
    
    %if event == 1 then use the stopping criteria in the event function   
       
    if event == 1 
   
    Opt = odeset('Events', @event);
    [T,y] = ode23s(@(t,Y) covid(t,Y,vR,tR,f,B1,B2,b1,b3,B3) , tspan ,...
    init_cond, Opt);
    
    else

    [T,y] = ode23s(@(t,Y) covid(t,Y,vR,tR,f,B1,B2,b1,b3,B3) , tspan , ...
    init_cond);

    end
    
    %If plotn==1 then plot the system of equations
    
    if plotn == 1
        plotfxn(T,y)
    end
    
    S = y(:,1);
    I1u = y(:,2);
    I1a = y(:,3);
    I2 = y(:,4);
    R = y(:,5);    
end

%COVID FUNCTION

function dY_dt = covid(~,Y,vR,tR,f,B1,B2,b1,b3,B3)

% Relabel to easily keep track of compartments
S = Y(1);
I1u = Y(2);
I1a = Y(3);
I2 = Y(4);
R = Y(5);

dS_dt = -vR*S*I1u/(S + I1u); %eq (1)
dI1u_dt =  vR*S*I1u/(S + I1u) - (tR*f*(I1u/(S + I1u))) - (B1+B3)*I1u;  %eq (2)
dI1a_dt =  tR*f*(I1u/(S + I1u)) - (b1+b3)*I1a;  %eq (3)
dI2_dt =  B1*I1u + b1*I1a - B2*I2;  %eq (4)
dR_dt =  B2*I2 + B3*I1u + b3*I1a;  %eq (5)

dY_dt = [dS_dt; dI1u_dt; dI1a_dt; dI2_dt; dR_dt];

end

%EVENT FUNCTION

function [value,isterminal,direction] = event(~,Y)

value      = Y(3) + Y(4) - 0.05; 
isterminal = 1;   % HALT INTEGRATION WHEN I1a+I2 = 0.05
direction  = 0;

end

