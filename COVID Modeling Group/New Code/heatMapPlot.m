function [] = heatMapPlot(I_L, vr_vector, days_open_vec, yaxisTitle)



figure

imagesc(I_L, vr_vector, days_open_vec);
xlabel('Change in P Value','FontSize',15);
ylabel(yaxisTitle,'FontSize',15);
%caxis([0, .015]);
colorbar;
set(gca,'YDir','normal');  % Flip the y-axis to make it standardly oriented
title('Variation in the Maximum Days Open','FontSize',17);   
