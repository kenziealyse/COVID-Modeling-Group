function plotfxn(t, y)

    figure 

    plot(t,y(:,1),'-g',t,y(:,2),'b-',t,y(:,3),'b--',t,y(:,4),'r',t,y(:,5),'k','linewidth',3);
    set(0,'defaultaxesfontsize',17);
    xlabel('\bf Time (days)') 
    ylabel('\bf Population sizes (fraction)') 
    xticks([0:10:100])
    grid on

    legend('susceptible','unaware','aware','symptomatic','recovered','FontSize',15, 'location', 'best')


end

