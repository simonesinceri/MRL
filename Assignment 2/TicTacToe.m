% TIC-TAC-TOE
% Costruzione matrici P e R

clc
clear all
close all

S = 3^9;
A = 9; % posizione dove metto il mio simbolo
%%%%%%%%%%%% supponiamo cominci sempre l'avversario %%%%%%%%%%%%%%%%%%
list = [];

vX = [2 2 2];
vO = [3 3 3];

%%%%%%%%  Selezione stati AMMISSIBILI  %%%%%%%%%
for s = 1:S
    % valori 1->vuota, 2->X ,3->O  , avversario random O ,io metto le X
    [num1, num2, num3, num4, num5, num6, num7 ,num8, num9] = ind2sub(3*ones(1,9), s);
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
    
    %controllo righe
    for i=1:3:7
        if(isequal(state(i:i+2),vX) || isequal(state(i:i+2),vO))
            numSeqEnd = numSeqEnd +1;
        end
    end
    %controllo colonne
    for i=1:3
        if(isequal([state(i) state(i+3) state(i+6)],vX) || isequal([state(i) state(i+3) state(i+6)],vO))
            numSeqEnd = numSeqEnd +1;
        end
    end
    
    %Controllo Diagonali
    if(isequal([state(1) state(5) state(9)],vX)|| isequal([state(1) state(5) state(9)],vO))
        numSeqEnd = numSeqEnd +1;
    end
    if(isequal([state(3) state(5) state(7)],vX) || isequal([state(3) state(5) state(7)],vO))
        numSeqEnd = numSeqEnd +1;
    end
    
    % CASO prima azione avversario
    if(numCroce == numCerchio-1 && numSeqEnd<3) % stato ammissibile
        list = [list, s]; % lista indici stati ammissibili
    end
    
end

%% Costruzione P

S = size(list,2);
P = zeros(S,S,A);

for s = 1:S  % s indice per matrice 
    
    st = list(s); % indice vero che rappr stato con sub2ind
    
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
        
        if(stato(a) ~= 1 || verifyVictory(stato) ~= 0) % verifico se azione possibile diversa da 1 e da 3
            % se azione non possibile rimango nello stesso stato e anche se lo stato è terminale
            P(s,s,a) = 1;
        else
            statoApp(a) = 2; % metto la mia azione
       
            for k=1:A
                statoApp2 = statoApp; % per aggiungere azione avversario
                
                if(statoApp(k) == 1) %
                    statoApp2(k) = 3;
                    sp = sub2ind(3*ones(1,9),statoApp2(1),statoApp2(2),statoApp2(3),statoApp2(4),...
                        statoApp2(5),statoApp2(6),statoApp2(7),statoApp2(8),statoApp2(9));
                    sp = find(list == sp, 1);
                    P(s,sp,a) =  1/(numVuote-1);
                end
            end
            
        end
    end
end

%% Costruzione R

rew = zeros(1,S);
for i=1:S
    
    st = list(i);
    [num1, num2, num3, num4, num5, num6, num7 ,num8, num9] = ind2sub(3*ones(1,9), st);
    stato = [num1, num2, num3, num4, num5, num6, num7 ,num8, num9];
    
    rew(i)= verifyVictory(stato);
end

R = zeros(S,A); % matrice Reward

for p=1:S
    for a=1:A
        R(p,a)= sum((P(p,:,a)).*rew);
    end
end

save data_tictactoe.mat P R list   
