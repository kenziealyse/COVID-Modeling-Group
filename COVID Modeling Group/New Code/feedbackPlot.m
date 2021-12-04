function [] = feedbackPlot(vR, I_L, I_U, I1a, I2, days_open_vec,...
    events_vec, T)


% Calculuate Infected Population

I = I1a + I2;

% PLOT THE RESULTS

figure

yline(I_U*100, '--', 'lineWidth', 2);
hold on
plot(T, 100*I, 'r', 'LineWidth',3);
hold on
plot(T, 100*vR, 'b', 'LineWidth',3);
hold on
yline(I_L*100, '--', 'lineWidth', 2);
legend('Total Infected','vR', 'FontSize',16);
ylabel('Percent of Population Infected', 'FontSize',16);
xlabel('Time (days)', 'FontSize',16);
title('Covid Feedback Plot', 'FontSize',16);
xlim([0 100])
ylim([0 45])


% PLOT THE RESULTS

figure

plot(I_L, days_open_vec, 'r', 'LineWidth',3);
ylabel('Days', 'FontSize',16);
xlabel('P', 'FontSize',16);
title('Covid Feedback Plot Days Open', 'FontSize',16);
xlim([0 max(I_L)])
ylim([0 100])

figure 

plot(I_L, events_vec, 'b', 'LineWidth',3);
ylabel('Closures', 'FontSize',16);
xlabel('P', 'FontSize',16);
title('Covid Feedback Plot Days Open', 'FontSize',16);


