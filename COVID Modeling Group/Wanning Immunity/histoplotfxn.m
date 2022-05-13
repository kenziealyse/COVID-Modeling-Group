% Plot Histogram

filenames = {'beta1', 'beta2', 'beta1tilde',...
    'beta3tilde', 'beta3', 'f', 'lowvr', 'highvr', 'allvr'}; %name file

figure_variables = {'beta1pvals.mat', 'beta2pvals.mat', 'beta1tildepvals.mat',...
    'beta3tildepvals.mat', 'beta3pvals.mat', 'fpvals.mat', 'lowvrpvals.mat', ...
    'highvrpvals.mat', 'allvrpvals.mat'};

for i = 1:length(figure_variables)
    
figure(i)

loadedvariable = strcat('variables/', figure_variables{i});

load(loadedvariable, 'pvals')

[N,edges] = histcounts(pvals,3);

histogram(pvals,75);
xlabel('\bf $\tilde{p}$ Value','Interpreter','latex', 'FontSize', 17)
ylabel('\bf Number of $\tilde{p}$ Value Occurences','Interpreter','latex', 'FontSize', 17)

set(gcf, 'Units', 'Inches');
pos = get(gcf, 'Position');
set(gcf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)]);

figure_name = ['/I2SA', filenames{i}, 'histo.pdf'];
    
dirPath = strcat('/','figures', figure_name); % Directory Path
    
saveas(gcf,[pwd dirPath]); % Save Figure in Folder
  
  

end
