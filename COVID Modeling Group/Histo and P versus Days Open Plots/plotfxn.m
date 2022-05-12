% Plot Histogram

filenames = {'beta1', 'beta2', 'beta1tilde',...
    'beta3tilde', 'beta3', 'f', 'lowvr', 'highvr'}; %name file

figure_variables = {'beta1pvals.mat', 'beta2pvals.mat', 'beta1tildepvals.mat',...
    'beta3tildepvals.mat', 'beta3pvals.mat', 'fpvals.mat', 'lowvrpvals.mat', 'highvrpvals.mat'}


for i = 1:length(figure_variables)
    
figure(i)

load(figure_variables{i}, 'pvals')

[N,edges] = histcounts(pvals,3);



histogram(pvals,75);
title('\bf $\tilde{p}$ Values Resulting in Maximum Days Open','Interpreter','latex', 'FontSize', 20)
xlabel('\bf $\tilde{p}$ Value','Interpreter','latex', 'FontSize', 17)
ylabel('\bf Number of $\tilde{p}$ Value Occurences','Interpreter','latex', 'FontSize', 17)

figure_name = ['SA', filenames{i}, 'histo.eps'];
    
saveas(figure(i),figure_name); % Save Figure in Folder

end