function [s, a, r] = playRaceEpsilon(s0, policy, epsilon)
% genera episodio -> sequenza stati,azioni,ricompense 
% sequenze mi servono per applicare monte varlo methods

s = s0;
a = [];
r = [];

while s(end) ~= -1
    St = s(end);
    if rand <= epsilon   % Epsilon-Greedy
        At = randi(3,1,2);
        At = sub2ind([3 3], At(1),At(2));
    else
        At = policy(St,:);
        At = sub2ind([3 3], At(1),At(2));
    end
    [St1, Rt1] = run(St,At);
    s = [s, St1];
    a = [a, At];
    r = [r, Rt1];
end

