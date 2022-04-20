% funzione utilizzata in "policyIteration.m"
function vpi = policyEval(P, R, gamma, pi, v)

% P -> matrice delle probabilità di transizione
% R -> matrice delle ricompense
% gamma -> fattore di sconto
% pi -> policy,azione data dalla policy
% v -> value vecchio

S = size(P,1);

Ppi = zeros(S,S);
Rpi = zeros(S,1);
for s = 1:S     %pi(s) singola azione
    Ppi(s,:) = P(s,:,pi(s));
    Rpi(s) = R(s,pi(s));
end

while true
    vprec = v;
    %   R_t+1+gamma* * valPrecedente
    v = Rpi + gamma*Ppi*vprec; % prodotti tra matrici aggiorno contemporaneamente tutti gli stati
    if norm(vprec-v, Inf) < 1e-8 %era -6
        break
    end
end

vpi = v; % return