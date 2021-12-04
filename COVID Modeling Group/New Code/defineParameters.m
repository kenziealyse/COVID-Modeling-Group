function [f, B1, B2, b1, b3, B3, vR_U] = defineParameters(f, B1b, B2b...
    , b1b, b3b, B3b, vR_Ub)


% Parameters min and max values

B1_vec = (0.143:0.001:0.224);
B2_vec = (0.053:0.001:0.085);
B3_vec = (0.042:0.001:0.058); 
vR_U_vec = (0.45:.001:2);   


if vR_Ub == 1
    
    vR_start = vR_U_vec(1);
    vR_end = vR_U_vec(end);
    vR_U = (vR_end-vR_start).*rand(1) + vR_start;
    
else
    vR_U = 0.45;
end


if B1b == 1
    
    b1_start = B1_vec(1);
    b1_end = B1_vec(end);
    B1 = (b1_end-b1_start).*rand(1) + b1_start; 
    
else
    
    B1 = 0.143;
    
end

if B2b == 1
    
    b2_start = B2_vec(1);
    b2_end = B2_vec(end);
    B2 = (b2_end-b2_start).*rand(1) + b2_start;
   
    
else
 
    B2 = 0.06;

end


if  b1b == 1
    
    b1_start = B1_vec(1);
    b1_end = B1_vec(end);
    b1 = (b1_end-b1_start).*rand(1) + b1_start;

else
    b1 = 0.143;
    
end


if b3b == 1

    b3_start = B3_vec(1);
    b3_end = B3_vec(end);
    b3 = (b3_end-b3_start).*rand(1) + b3_start;

else
   b3 = 0.05; 
end

if B3b == 1
    
    b3_start = B3_vec(1);
    b3_end = B3_vec(end);
    B3 = (b3_end-b3_start).*rand(1) + b3_start;

else
   B3 = 0.05;   
end

