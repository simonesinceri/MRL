function [s, a, r] = playRaceEpsilon(s0, policy)
% genera episodio -> sequenza stati,azioni,ricompense 
% sequenze mi servono per applicare monte varlo methods
s = s0;
a = [];
r = [];

while s(end) ~= -1
    St = s(end);
    if rand <= epsilon   % Epsilon-Greedy
        At = randi(2);
    else
        At = policy(St);
    end
    [St1, Rt1] = blackjack(St,At);
    s = [s, St1];
    a = [a, At];
    r = [r, Rt1];
end