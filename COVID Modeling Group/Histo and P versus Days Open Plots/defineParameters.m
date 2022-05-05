%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function is used to define model parameters either randomly within a 
% certain range or with a prespecified value using boolean expressions.
%
%Inputs (0 to randomize, 1 to set with prespecified value): 
%
%   f - fraction of true positives
%   B1b - 0 or 1 
%   b2B - 0 or 1 
%   b1b - 0 or 1 
%   b3b - 0 or 1 
%   B3b - 0 or 1 
%   low_vr - 0 or 1 
%   low_vr - 0 or 1 
%   high_vr - 0 or 1 
%   vR_Ub - 0 or 1 
%
%Outputs:
%
%   f = fraction of true positives
%   B1 = value for beta 1
%   B2 = value for beta 2
%   b1 = value for beta 1 tilde
%   b3 = value for beta 3 tilde
%   B3 = value for beta 3
%   vR_U = value for the upper value of Vr
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [f, B1, B2, b1, b3, B3, vR_U] = defineParameters(fb, B1b, B2b...
    , b1b, b3b, B3b, low_vr, high_vr, vR_Ub)


% Parameters min and max values

B1_vec = (0.143:0.001:0.224);
B2_vec = (0.053:0.001:0.085);
B3_vec = (0.042:0.001:0.058); 
f_vec = (0.5:0.001:1); 


% Set vR to be low, high, or both low and high values

if low_vr == 1 
    
    vR_U_vec = (0.3:.01:.6);

elseif high_vr == 1
    
    vR_U_vec = (1:.01:2);

else
    
    vR_U_vec = (0.45:.001:2); 
    
end

% If vR_Ub == 1 then randomize the value for vR. Else, set vR = 0.45

if vR_Ub == 1
    
    vR_start = vR_U_vec(1);
    vR_end = vR_U_vec(end);
    vR_U = (vR_end-vR_start).*rand(1) + vR_start;
    
else
    vR_U = 0.45;
end


% If B1b == 1 then randomize the value for B1. Else, set B1 = 0.143

if B1b == 1
    
    b1_start = B1_vec(1);
    b1_end = B1_vec(end);
    B1 = (b1_end-b1_start).*rand(1) + b1_start; 
    
else
    
    B1 = 0.143;
    
end


% If B2b == 1 then randomize the value for B2. Else, set B2 = 0.06

if B2b == 1
    
    b2_start = B2_vec(1);
    b2_end = B2_vec(end);
    B2 = (b2_end-b2_start).*rand(1) + b2_start;
   
    
else
 
    B2 = 0.06;

end


% If b1b == 1 then randomize the value for b1. Else, set b1 = 0.143

if  b1b == 1
    
    b1_start = B1_vec(1);
    b1_end = B1_vec(end);
    b1 = (b1_end-b1_start).*rand(1) + b1_start;

else
    b1 = 0.143;
    
end


% If b3b == 1 then randomize the value for b3. Else, set b3 = 0.05

if b3b == 1

    b3_start = B3_vec(1);
    b3_end = B3_vec(end);
    b3 = (b3_end-b3_start).*rand(1) + b3_start;

else
   b3 = 0.05; 
end


% If B3b == 1 then randomize the value for B3. Else, set B3 = 0.05

if B3b == 1
    
    b3_start = B3_vec(1);
    b3_end = B3_vec(end);
    B3 = (b3_end-b3_start).*rand(1) + b3_start;

else
   B3 = 0.05;   
end

% If fb == 1 then randomize the value for f. Else, set f = 0.85

if fb == 1
    
    f_start = f_vec(1);
    f_end = f_vec(end);
    f = (f_end-f_start).*rand(1) + f_start;

else
   f = 0.85;   
end



