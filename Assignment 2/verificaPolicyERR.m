clc
clear

load data_tictactoe.mat
load PI.mat  % policyPI
%load VI.mat  %policyVI
%%
S = size(list,2);
A = 9;
cont = 0;
for i=1:S

    s = list(i); %indice stato

    [num1, num2, num3, num4, num5, num6, num7 ,num8, num9] = ind2sub(3*ones(1,9), s);
    state = [num1, num2, num3, num4, num5, num6, num7 ,num8, num9];
    
    act = policyPI(i);
    
    numVuote = 0;
    for ii=1:9 % conto caselle vuote e tengo presente gli indici
        if(state(ii) == 1)
            numVuote = numVuote+1;
        end
    end

    if(state(act) ~= 1 && numVuote ~= 0)
        if(verifyVictory(state) == 0)
            fprintf("ERROR: state %d, %d \n",s,i)
            cont = cont + 1;
        end
    end

end

cont