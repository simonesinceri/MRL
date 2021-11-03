clear all
close all
clc

numEpisodes = 1e4;
gamma = 0.9;   % modifica qst elementi  gamma epsilon e diminuisci NumEp
epsilon = 0.3;

S = 20*20*11*11;
A = 3*3; % azione su x e y

N = zeros(S,A);
Q = zeros(S,A);

% devo cambiare policy -> azione è coppia valori
policy = randi(2,S,2);
policyIniz = policy;


for e = 1:numEpisodes
    %stato iniziale -> li devo mapapre con sub2ind
    %s0 = randi(S); % vado con indice
    %s0 = sub2ind([20 20 11 11],20,randi([6 15]),randi(11),randi(11)); 
    s0 = sub2ind([20 20 11 11],20,randi([6 15]),6,6); 
    a0 = randi(3,1,2);
    [s, a, r] = playRaceEpsilon(s0, policy, epsilon);
    G = 0;
    for t = length(s)-1: -1: 1
        G = r(t) + gamma*G;
       % at = sub2ind([3 3], a(2*t-1),a(2*t));
        e
        N(s(t),a(t)) = N(s(t),a(t)) + 1;% attenz in a(t)
        Q(s(t),a(t)) = Q(s(t),a(t)) + 1/N(s(t),a(t))*(G - Q(s(t),a(t)));
        Astar = find(Q(s(t),:) == max(Q(s(t),:)), 1, 'first'); % a dimensione 2
        [A1,A2] = ind2sub([3 3], Astar); 
        policy(s(t),:) = [A1 A2];
    end
end

%%
save mc_race_10e5.mat policy
%%

GW = createGridWorld(20,20,'Kings');
GW.CurrentState = "[20,8]";
%GW.ObstacleStates = ["[3,3]";"[3,4]";"[3,5]";"[4,3]"];
GW.TerminalStates = ["[6,20]";"[7,20]";"[8,20]";"[9,20]";"[10,20]"];
GW.ObstacleStates = "[4,3]";
env = rlMDPEnv(GW);
plot(env)

s0= GW.CurrentState;
[sp, r, isTerminal] = step(env, 2);
%plot(env)
[sp, r, isTerminal] = step(env, 1);
%plot(env)
[sp, r, isTerminal] = step(env, 4);
plot(env)

