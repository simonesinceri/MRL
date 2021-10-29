% funzione utilizzata in "policyIteration.m"
function pip = policyImprovement(P, R, gamma, value)

S = size(P,1);
A = size(R,2);

pip = zeros(S,1);

for s = 1:S
    q = zeros(A,1);
    for a = 1:A
        trans = P(s,:,a);
        q(a) = R(s,a) + gamma*trans*value;
    end
    pip(s) = find(q == max(q), 1);
end