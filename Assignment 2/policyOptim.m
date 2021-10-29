% funzione utilizzata in "valueIteration.m"
function [newValue, policy] = policyOptim(P, R, gamma, value)

S = size(P,1);
A = size(R,2);

newValue = zeros(S,1);
policy = zeros(S,1);

for s = 1:S
    q = zeros(A,1);
    for a = 1:A
        trans = P(s,:,a);
        q(a) = R(s,a) + gamma*trans*value;
    end
    newValue(s) = max(q);
    policy(s) = find(q == max(q), 1);
end