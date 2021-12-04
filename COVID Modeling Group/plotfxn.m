function plotfxn(t, y, graph_title)

figure 

plot(t,y(:,1),'-g',t,y(:,2),'b-',t,y(:,3),'b--',t,y(:,4),'r',t,y(:,5),'k','linewidth',3);
title(graph_title,'FontSize',20)
xlabel('Time (days)','FontSize',17) 
ylabel('Population sizes (fraction)','FontSize',17) 
grid on

hold on

% if Tc < 100
% 
% xline(Tc,'-.','linewidth',3)
% legend('susceptible','unaware','aware','symptomatic','recovered','T_c','FontSize',15, 'location', 'northeast')
% 
% else
%     
%     %legend('susceptible','unaware','aware','symptomatic','recovered','FontSize',15, 'location', 'best')
%     
% end

end


