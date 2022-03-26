function verificaAddestramento(w,gridx,M,N,A,limSx,limDx,delta)

% Carico eventuali dati addestrati,devo prima fare il load
% load addestramentoSARSA_1000episodes_delta1.mat

%s = [0; (rand*4-rand*4)] % [y,x] sono inverite sul simulatore
s = [0;max(min(normrnd(0,1)*4,4),-4)]
% Caso limite
%s = [0,4]; % caso 4 mi rimane a x = 1 potrebbe apprendere meglio, o problema di griglie
% Soffre la parte sinistra, forse non esplora bene quella parte
% Capita che quando fuori strada va sempre dritto?? -> serve più exper???
% rivedi caso riga precedente con SARSA

% Con epsgreedy prende anche az causale -> gli do epsilon = 0
a = epsGreedy(s, w, 0, gridx, M, N, A);
i = 1;

state = zeros(7,3);
state(1,1:2) = s;

for y=1:1:6
    %x = features(s, a, gridx, M, N, A);
    %dati = Road_Scenario(x_iniz,y_iniz,x_next,y*5); % prendo dati(end)
    [sp, r, isTerminal] = dynamics(s, a, limSx, limDx, y, delta,i);
    % Eventuale visualizzione di r,a per vedere come si comporta
    fprintf("r = %f a = %f \n", r, (a-2))
    
    % da qui devo far uscire il mio stato
    if isTerminal
        %w = w + alpha*(r - w'*x)*x; % x è il gradiente rispetto w
        fprintf("Fine Episodio \n")
    else
        % Con epsgreedy prende anche az causale -> gli do epsilon = 0
        ap = epsGreedy(sp, w, 0, gridx, M, N, A); % azione success
        %xp = features(sp, ap, gridx, M, N, A); % features stato success
        %w = w + alpha*(r + gamma*w'*xp - w'*x)*x;
    end
    s = sp; % aggiorno
    a = ap;
    state(y+1,1:2) = s;

    if(y == 6)
        close all
        visualizeRoad(state);
        s
    end

end

end