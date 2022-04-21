% Simulazione partita Tic-Tac-Toe
%% Caricamento dati
clc
clear 

load data_tictactoe_v2.mat
load PI_v2.mat  % policyPI
load VI_v2.mat  %policyVI

%% Simulazione
clc
state = ones(1,9);

actPoss = [1 2 3 4 5 6 7 8 9];       
numVuote = 9;

visualizeGrid(state)
fprintf('\n')

while (numVuote >= 1) 
    
    s = sub2ind(3*ones(1,9),state(1),state(2),state(3),state(4),state(5),...
        state(6),state(7),state(8),state(9)); % indice stato vero
    
    sp = find(list == s, 1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % mia azione ottima
    %myAct = policyPI(sp) % Policy Iteration
    myAct = policyVI(sp) % Value Iteration
    if(state(myAct) == 1)
        state(myAct) = 2;
    else
        fprintf("ERROR \n")
        break
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % devo togliere la mia azione da quelle possibili per avversario
    remove = find(actPoss == myAct, 1);
    actPoss(remove) = [];
    numVuote = numVuote -1;
    
    % azione casuale avversario
    if(numVuote > 1)
        actInd = randi(numVuote);
        actAvv = actPoss(actInd)  % qui sono uguali perchè sono disp tutte le azioni
        actPoss(actInd) = [];
        state(actAvv) = 3;
        numVuote = numVuote -1;
    end

    visualizeGrid(state)
    fprintf('\n')
    
    %controllo vittoria
    if(verifyVictory(state) == 1) 
        disp('Win X ->Fine Episodio')
        return
    end
    if(verifyVictory(state) == -1) 
        disp('Win O -> Fine Episodio')
        return
    end
end
