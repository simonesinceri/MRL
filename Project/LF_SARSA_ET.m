% Simulation Environment
% Linear Features SARSA_ET

clear all
close all 
clc

% devo definire i miei upper/lower bound dell'ambiente
limSx = 4;
limDx = -4;

M = 3; % numero celle
N = 4;%4; % numero griglie  num righe
% funziona meglio così che con M=4 e N=8

A = 3; % numero azioni [-1,0,1]
passo = 1; % passo della mia azione
% Potrei mettere un delta che diminuisce

episodes = 1e3;
epsilon = 1e-1;
alpha = 1e-3;
% lambda = 0 -> SARSA semplice, lambda = 1 -> MC
lambda = 1; 
gamma = 1;

nCells = (M + 1); % dimensione features per una cella
d = A*N*nCells; % dimensione vettore pesi da aggiornare

[gridx] = buildTiles(limSx, limDx, M, N);
w = zeros(d, 1);

%tic
for i=1:episodes
    z = zeros(d,1);
    %x_start = (normrnd(0,1)*4);
    % valore random tra 4 -4 
    %%% qst potrebbe essere il problema %%%%%%%%%%%%%%%%%%%%%%%%%%
    %s = [0; (rand*4-rand*4)]; % [y,x] sono inverite sul simulatore 
    s = [0;max(min(normrnd(0,1)*4,4),-4)]; % anche così il problema persiste però stavolta da lato opposto
    a = epsGreedy(s, w, eps, gridx, M, N, A);

    if(mod(i,10) == 0)
        fprintf("Episodio: %d \n",i)
    end

    state = zeros(7,3);
    state(1,1:2) = s;
    rewEpisodio = 0;
    
    for y=1:1:6
    
        x = features(s, a, gridx, M, N, A);
        [sp, r, isTerminal] = dynamics(s, a, limSx, limDx, y, passo,i);
        rewEpisodio = rewEpisodio + r;
        if isTerminal
            delta = r - w'*x;
        else
            ap = epsGreedy(sp, w, epsilon, gridx, M, N, A);
            xp = features(sp, ap, gridx, M, N, A);
            delta = r + gamma*w'*xp - w'*x;
        end
        z = gamma*lambda*z + x;
        w = w + alpha*delta*z;
        s = sp; % aggiorno
        a = ap;
        state(y+1,1:2) = s;
    end

    fprintf("SumRewardEpisodio = %f \n", rewEpisodio)
    if(mod(i,50) == 0)
        close all
        visualizeRoad(state);
    end

end
%toc