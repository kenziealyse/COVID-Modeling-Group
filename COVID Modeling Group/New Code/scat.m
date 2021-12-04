function [] = scat(j, days_open_vec, I_L, params, vR_U)


f = params(1);
B1 = params(2);
B2 = params(3);
b1 = params(4);
b3 = params(5);
B3 = params(6);


    [max1(j), ind1(j)] = max(days_open_vec);
    days_open_vec(ind1(j))      = -Inf;
    max1_p(j) = I_L(ind1(j));
    
    
    [max2(j), ind2(j)] = max(days_open_vec);
    days_open_vec(ind2(j))      = -Inf;
    max2_p(j) = I_L(ind2(j));
    
    
    [max3(j), ind3(j)] = max(days_open_vec);
    days_open_vec(ind3(j))      = -Inf;
    max3_p(j) = I_L(ind3(j));
    
    days_open_vec(ind1(j))      = max1(j);
    days_open_vec(ind2(j))      = max2(j);
    days_open_vec(ind3(j))      = max3(j);
      
    labels = num2str(b1);
    
    plot(I_L, days_open_vec, 'LineWidth',.5,'DisplayName',labels);
    title('Covid Feedback Plot Days Open', 'FontSize',16);
    %legend(labels)
    xlim([0 max(I_L)])
    ylim([0 100])
    ylabel('Days', 'FontSize',16);
    xlabel('P', 'FontSize',16);
    hold on
    
   
    
    plot(vR_U, max(days_open_vec))
   
    
    % legend show
% 
% 
% figure
% 
% scatter(max1_p, max1, 'filled', 'blue')
% 
% legend('max1')
% 
% hold on
% 
% scatter(max2_p, max2, 'filled', 'red')
% 
% legend('max1', 'max2')
% 
% 
% hold on
% 
% scatter(max3_p, max3, 'filled', 'green')
% 
% legend('max1', 'max2', 'max3')
% 
% ylabel('Days', 'FontSize',16);
% xlabel('P', 'FontSize',16);
% title('P Value Corresponding to First, Second, and Third Maximum Days open')
% xlim([0 max(I_L)])
% ylim([0 100])


    