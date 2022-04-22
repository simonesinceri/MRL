clear all
close all
clc

numEpisodes = 1e6;
gamma = 1;   % con 0.9 non va
epsilon = 0.2;

S = 20*20*11*11;
A = 3*3; % azione su x e y

N = zeros(S,A);
Q = zeros(S,A);

% devo cambiare policy -> azione è coppia valori
policy = randi(3,S,2);
policyIniz = policy;


for e = 1:numEpisodes
    %stato iniziale -> li devo mapapre con sub2ind
    % parti da linea partenza con velocità nulla
    s0 = sub2ind([20 20 11 11],20,randi([6 15]),6,6); 
    a0 = randi(3,1,2);
    [s, a, r] = playRaceEpsilon(s0, policy, epsilon);
    G = 0;
    e
    for t = length(s)-1: -1: 1
        G = r(t) + gamma*G;
        N(s(t),a(t)) = N(s(t),a(t)) + 1;
        Q(s(t),a(t)) = Q(s(t),a(t)) + 1/N(s(t),a(t))*(G - Q(s(t),a(t)));
        Astar = find(Q(s(t),:) == max(Q(s(t),:)), 1, 'first'); % a dimensione 2
        [A1,A2] = ind2sub([3 3], Astar); 
        policy(s(t),:) = [A1 A2];
    end
end


%save mc_race_10e6_GAMMA1.mat policy
  