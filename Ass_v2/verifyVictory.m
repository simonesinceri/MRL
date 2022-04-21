% funzione che esamina lo stato e determina
% se è finale, assegnando la reward in base al vincitore

%COMINCIA L'AVVERSARIO -> quindi se ci sono 2 sequenza vittoria ho vinto io
% altrimenti sarebbe già stato terminale

function reward = verifyVictory(state)

% problema nel caso 2 sequenze di vittoria
% me la spiccio con l'ordine degli if , metto prima gli if delle X

vX = [2 2 2];
vO = [3 3 3];

reward = 0;

% caso Vittoria X  [2 2 2]
%controllo righe
for i=1:3:7
    if(isequal(state(i:i+2),vX))
        reward = 1;
        return
    end
end
%controllo colonne
for i=1:3
    if(isequal([state(i) state(i+3) state(i+6)],vX))
        reward = 1;
        return
    end
end

%Controllo Diagonali
if(isequal([state(1) state(5) state(9)],vX))
    reward = 1;
    return
end
if(isequal([state(3) state(5) state(7)],vX))
    reward = 1;
    return
end

% caso Vittoria O  [3 3 3]
%controllo righe
    for i=1:3:7
        if(isequal(state(i:i+2),vO))
            reward = -1;
            return
        end
    end
%controllo colonne
for i=1:3
    if(isequal([state(i) state(i+3) state(i+6)],vO))
        reward = -1;
        return
    end
end

%Controllo Diagonali
if(isequal([state(1) state(5) state(9)],vO))
    reward = -1;
    return
end
if(isequal([state(3) state(5) state(7)],vO))
    reward = -1;
    return
end


end