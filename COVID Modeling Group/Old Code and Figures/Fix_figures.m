param = [0.85, 0.143, 0.06, 0.143, 0.05, 0.05];

tR = 0.4;

vR = 0.5;

tspan = [0 100];

init_cond = [0.99 .01 0 0 0]';

event = 0;

plotn = 1 ;

graph_title = 'hi';

covidsolver5(param, tR, vR, init_cond, tspan, event, plotn, graph_title);


tR = 0.2;

vR = 0.45;


covidsolver5(param, tR, vR, init_cond, tspan, event, plotn, graph_title);


