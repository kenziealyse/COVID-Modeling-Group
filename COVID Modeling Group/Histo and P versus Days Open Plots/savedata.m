% CLEAR THE WORKSPACE

clear all;
close all;


% Fix Parameter Values

f  = 0.85;   % Fraction of true positives
B1 = 0.143;  % beta 1
B2 = 0.06;   % beta 2
b1 = 0.143;  % beta 1 tilde
b3 = 0.05;   % beta 3 tilde
B3 = 0.05;   % beta 3

params = [f, B1, B2, b1, b3, B3]; % vector of parameter values

% Boolean Values for Randomizing Parameters (1 to randomize)

B1b = 0;
B2b = 0;
b1b = 1;
b3b = 0;
B3b = 0;
fb = 0;
low_vr = 0;
high_vr = 0;
vR_Ub = 0;

varstr = '$\beta_1 = $'; % Name of variable that is being randomized for the graph

var1 = B1b;

[days_open_vec1, I_L1, pvals1] = generate_data(B1b, B2b, b1b, b3b, B3b, ...
    fb, low_vr, high_vr, vR_Ub, varstr, var1);

save('pvals', 'pvals1');
save('days_open_vec', 'days_open_vec1');
save('I_L', 'I_L1');