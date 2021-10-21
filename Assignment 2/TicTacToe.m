% TIC-TAC.TOE
% Costruzione matrici P e R

clc
clear all 
close all

S = 3^9;
A = 9; % posizione dove metto il mio simbolo
%%%%%%%%%%%% supponiamo cominci sempre l'avversario %%%%%%%%%%%%%%%%%%
list = [];

% Selezione stati AMMISSIBiLI
for s = 1:S
    % valori 1->vuota, 2->X ,3->O
    [num1, num2, num3, num4, num5, num6, num7 ,num8, num9] = ind2sub(3*ones(1,9), s);
    % controllo stato ammisibile -> e posso mettere = 0 riga e colonna per
    % tutte le azioni
    state = [num1, num2, num3, num4, num5, num6, num7 ,num8, num9]; % stato come vettore
    
    numCroce = 0;
    numCerchio = 0;
    numSeqEnd = 0;
    
    for i=1:9
        if(state(i) == 2)
            numCroce = numCroce+1;
        end
        if(state(i) == 3)
            numCerchio = numCerchio+1;
        end
    end
    % devo filtrare ancora gli stati con 3 simboli che formano vittoria
    %ci deve essere soltanto una sequenza di 3 simboli uguali rig/col/diag
    
    
    %controllo per riga
    if(state(1:3) == [2 2 2] | state(1:3) == [3 3 3])
        numSeqEnd = numSeqEnd +1;
    end
    if(state(4:6) == [2 2 2] | state(4:6) == [3 3 3])
        numSeqEnd = numSeqEnd +1;
    end
    if(state(7:9) == [2 2 2] | state(7:9) == [3 3 3])
        numSeqEnd = numSeqEnd +1;
    end
    %controllo per colonna
    if([state(1) state(4) state(7)] == [2 2 2] | [state(1) state(4) state(7)] == [3 3 3])
        numSeqEnd = numSeqEnd +1;
    end
    if([state(2) state(5) state(8)] == [2 2 2] | [state(2) state(5) state(8)] == [3 3 3])
        numSeqEnd = numSeqEnd +1;
    end
    if([state(3) state(6) state(9)] == [2 2 2] | [state(3) state(6) state(9)] == [3 3 3])
        numSeqEnd = numSeqEnd +1;
    end
    %controllo diagonali
    if([state(1) state(5) state(9)] == [2 2 2] | [state(1) state(5) state(9)] == [3 3 3])
        numSeqEnd = numSeqEnd +1;
    end
    if([state(3) state(5) state(7)] == [2 2 2] | [state(3) state(5) state(7)] == [3 3 3])
        numSeqEnd = numSeqEnd +1;
    end
    
    % CASO prima azione avversario
    if(numCroce == numCerchio-1 && numSeqEnd<3) % stato ammissibile
        list = [list, s]; % lista indici stati ammissibili
    end
    % caso con due sequenze di vittoria -> vedi chi gioca prima per capire
    % vincitore
end

%% Costruzione P

S = size(list,2);
P = zeros(S,S,A);

for s = 1:S
    
    st = list(s);
    
    [num1, num2, num3, num4, num5, num6, num7 ,num8, num9] = ind2sub(3*ones(1,9), st);
    stato = [num1, num2, num3, num4, num5, num6, num7 ,num8, num9];
    
    numVuote = 0;
    
    for i=1:9 % conto caselle vuote e tengo presente gli indici
        if(stato(i) == 1)
            numVuote = numVuote+1;
        end
    end
    
    for a=1:A
        statoApp = stato;
        
        if(stato(a) ~= 1) % verifico se azione possibile diversa da 1 e da 3
            % se azione non possibile rimango nello stesso stato?
            %metto if==1
            P(s,s,a) = 1;
            % in realtà è gia messa a zero per inizializzazione
        else
            statoApp(a) = 2; % metto la mia azione
            
            %sp = sub2ind(3*ones(1,9),stateApp(1),stateApp(2),stateApp(3),stateApp(4),...
            %   stateApp(5),stateApp(6),stateApp(7),stateApp(8),stateApp(9));
            % stato successivo dopo mia azione devo considerare anche
            % avversario
            
            for k=1:A
                statoApp2 = statoApp; % per aggiungere azione avversario
                if(statoApp(k) == 1)
                    statoApp2(k) = 3;
                    sp = sub2ind(3*ones(1,9),statoApp2(1),statoApp2(2),statoApp2(3),statoApp2(4),...
                        statoApp2(5),statoApp2(6),statoApp2(7),statoApp2(8),statoApp2(9));
                    sp = find(list == sp, 1);
                    %P(s,sp,a) =   P(s,sp,a) + 1/(numVuote-2);
                    P(s,sp,a) =  1/(numVuote-1);
                end
            end
            
        end
    end
end

% costr matrice P azione per azione, scegliendo azione prob 1 finisco in e
% con prob random(distrbuita uniformemente) stato successivo(azione avversario)
% considerare AFTER STATE

%% Costruzione R

R = zeros(S,A); % matrice Reward
%scansira statie vedere se c'è vittoria
for p=1:S
    
    st = list(s+1);
    [num1, num2, num3, num4, num5, num6, num7 ,num8, num9] = ind2sub(3*ones(1,9), st);
    stato = [num1, num2, num3, num4, num5, num6, num7 ,num8, num9];
    
    for a=1:A
        statoApp = stato;
        if(stato(a) == 1) % se casella vuota
            statoApp(a) = 2; %metto la X
            %controllo sulla vittoria
            % stati con azione avversario
        end
        
    end
end

    
% ricompensa in funzione dello stato in cui mi trovo???
%%
fprintf("\nmario")
