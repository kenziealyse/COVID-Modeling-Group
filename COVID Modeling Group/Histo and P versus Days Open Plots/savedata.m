%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file is used for plotting p (I_l) versus days open. In the file
% we use defineParameters to randomly choose different parameters. We then
% run the the covid feedback solver for the randomly chosen variable and
% plot the days open versus p. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% CLEAR THE WORKSPACE

clear all;
close all;

% Boolean Values for Randomizing Parameters (1 to randomize)

B1b = 1;     %beta 1
B2b = 0;     %beta 2
b1b = 0;     %beta 1 tilde
b3b = 0;     %beta 3 tilde
B3b = 0;	 %beta 3
fb = 0;      %f
low_vr = 0;  %low vr vector values
high_vr = 0; %high vr vector values
vR_Ub = 0;   % vr boolean expression

variable_names = {'$\beta_1 = $', '$\beta_2 = $', '$\tilde{beta_1} = $',...
    '$\tilde{beta_3} = $', '$\beta_3 = $', '$f = $', '$v_r = $', '$v_r = $'}; %legend variable

filenames = {'beta1', 'beta2', 'beta1tilde',...
    'beta3tilde', 'beta3', 'f', 'lowvr', 'highvr'}; %name file


% CHANGE THESE

index = 1; % which string do you want?

var1 = 2; % which variable value in the legend? params = [f, B1, B2, b1, b3, B3, vR_U];

%%%%%%%

varstr = variable_names{index}; % Name of variable that is being randomized for the graph

iter = 1000; % How many iterations? 

[days_open_vec, I_L, pvals] = generate_data(B1b, B2b, b1b, b3b, B3b, ...
    fb, low_vr, high_vr, vR_Ub, varstr, var1, iter);

% Name the files

pvalsfilename = [filenames{index} 'pvals'];
daysOpenfilename = [filenames{index} 'daysopen'];
ILfilename = [filenames{index} 'IL'];

%save the files

save(pvalsfilename, 'pvals');
save(daysOpenfilename,'days_open_vec');
save(ILfilename,'I_L');