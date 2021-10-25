% funzione che esamina lo stato e determina
% se è finale, assegnando la reward in base al vincitore

% la posso usare anche come funz "isTerminal" in base ai valori, che mi da
% capisco se stato terminale, caso pareggio -> grilgia piena non posso
% andare avanti

%COMINCIA L'AVVERSARIO -> quindi se ci sono 2 sequenza vittoria ho vinto io
% altrimenti sarebbe già stato terminale

function reward = verifyVictory(state)

% problema nel caso 2 sequenze di vittoria
% me la spiccio con l'ordine degli if , metto prima gli if delle X

% valori 1->vuota, 2->X ,3->O
    %controllo per riga
    if(state(1:3) == [2 2 2] | state(4:6) == [2 2 2] | state(7:9) == [2 2 2] | ...
          [state(1) state(4) state(7)] == [2 2 2] | [state(2) state(5) state(8)] == [2 2 2] | ...
          [state(3) state(6) state(9)] == [2 2 2] | [state(1) state(5) state(9)] == [2 2 2] | ...
          [state(3) state(5) state(7)] == [2 2 2])
      
        reward = 1;
        return
        
    elseif(state(1:3) == [3 3 3] | state(4:6) == [3 3 3] | state(7:9) == [3 3 3] | ...
          [state(1) state(4) state(7)] == [3 3 3] | [state(2) state(5) state(8)] == [3 3 3] | ...
          [state(3) state(6) state(9)] == [3 3 3] | [state(1) state(5) state(9)] == [3 3 3] | ...
          [state(3) state(5) state(7)] == [3 3 3])
      
        reward = -1;
        return
        
    else  % problema caso che dovrebbe dare 0 mi da -1
        
        reward = 0;
        
    end
    
end