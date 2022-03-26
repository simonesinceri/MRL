% Simulation Environment
% Linear Features LS
% converge prima il SARSA
clear all
close all 
clc

% devo definire i miei upper/lower bound dell'ambiente
limSx = 4;
limDx = -4;

M = 3; % numero celle
N = 8;%4; % numero griglie  num righe

A = 3; % numero azioni [-1,0,1]
delta = 1; % passo della mia azione
% Potrei mettere un delta che diminuisce

episodes = 1000; %1e3;  % prova con questo num di episodi e tolgi il plot dello scenario
epsilon = 1e-1;
alpha = 1e-3;
gamma = 1;

nCells = (M + 1); % dimensione features per una cella
d = A*N*nCells; % dimensione vettore pesi da aggiornare

[gridx] = buildTiles(limSx, limDx, M, N);

% metodo minimi quadratici -> formula iterativa per calcolo A^(-1)
iA = 1e6*eye(d);
B = zeros(d,1);
w = randn(d, 1);

%tic
for i=1:episodes
    %x_start = (normrnd(0,1)*4);
    % valore random tra 4 -4 
    %%% qst potrebbe essere il problema %%%%%%%%%%%%%%%%%%%%%%%%%%
    s = [0; (rand*4-rand*4)]; % [y,x] sono inverite sul simulatore   
    a = epsGreedy(s, w, eps, gridx, M, N, A);

    if(mod(i,10) == 0)
        fprintf("Episodio: %d \n",i)
    end

    state = zeros(7,3);
    state(1,1:2) = s;
    rewEpisodio = 0;
    
    for y=1:1:6
    
        x = features(s, a, gridx, M, N, A);
        [sp, r, isTerminal] = dynamics(s, a, limSx, limDx, y, delta,i);
        rewEpisodio = rewEpisodio + r;
        
        ap = epsGreedy(sp, w, epsilon, gridx, M, N, A);
        xp = features(sp, ap, gridx, M, N, A);
        
        % Aggiornamento
        iA = iA - iA*x*(x - gamma*xp)'*iA/(1+(x - gamma*xp)'*iA*x);
        B = B + r*x;
        w = iA*B;
     
        
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
