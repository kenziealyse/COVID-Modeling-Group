function fin_vals = noSS_func(Vr, Tr, param, init_cond1, tspan)

%Preallocate space in array

fin_vals = zeros(2,length(Vr));

for i = 1:length(Vr)

    vR_fun = @(t) pulse_vR_fun(t,.22,.22,7,0); %(t, vR_low, vR_high, party_days, single_event)

    start = 1; %Used to decrease number of loops later on

    if i > 1
        %After first loop check if previous value for Tr was NaN, if so then
        %that means no amount of testing keeps peak below .05. Thus, since Vr
        %is now higher, result will also be NaN so fill and skip to next
        %iteration of loop
        
        %Should you always break here, because then testing will never
        %work?
        if isnan(fin_vals(2,i-1))
            fin_vals(1:2,i) = [Vr(i),NaN];
            continue;
        end
        
        %If here, previous Tr is not NaN so check what previous Tr value
        %was. As Vr is higher it must be at least same as previous Tr.
        
        start = find(Tr==(fin_vals(2,i-1)),1); %Setting start equal to wherever you are at in the array so that you don't check
        %the previous Tr values for the higher vr values
    end
    
    for j = start:length(Tr) %Starting where left off
        
        %Calculate tR, run model, get peak of known infected
        tR_fun = @(t, S, I1u) pulse_tR_fun(t,S,I1u, Tr(j),7,0); %(t, S, I1u, testing rate, days_tested, delay after party)
        [T, S, I1u, I1a, I2, R] = covidsolver(param, tR_fun, vR_fun, init_cond1, tspan, 0, 0);
        peak = max(I1a+I2)
        
        %If peak drops below (or starts below) 0.05, add current Vr and Tr
        %to fin_vals and exit loop
        if peak<0.05
            fin_vals(1:2,i) = [Vr(i),Tr(j)];
            break;
        end
    end
    
    
    %Check if a value has not been input in fin_val for Vr(i), 
    if fin_vals(1,i) == 0
        %If here, then no value of Tr brings peak below .05. Thus print NaN
        %as Tr value corresponding to Vr(i)
        fin_vals(1:2,i) = [Vr(i),NaN];
    end
    
end
