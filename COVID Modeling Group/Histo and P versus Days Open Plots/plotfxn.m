% Plot Histogram

figure(2)

load('pvals.mat', 'pvals1')

    

[N,edges] = histcounts(pvals1,3);


histogram(pvals1,75)
title('\bf $\tilde{p}$ Values Resulting in Maximum Days Open','Interpreter','latex', 'FontSize', 20)
xlabel('\bf $\tilde{p}$ Value','Interpreter','latex', 'FontSize', 17)
ylabel('\bf Number of $\tilde{p}$ Value Occurences','Interpreter','latex', 'FontSize', 17)