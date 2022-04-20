clear all
close all
clc

load data_tictactoe.mat
gamma = 0.9;

S = size(P,1);
A = size(R,2);

policy = randi(A,[S,1]);
value = zeros(S,1); % funzione valore iniziale

oldpolicy = policy;

tic
while true
    value = policyEval(P, R, gamma, policy, value);
    policy = policyImprovement(P, R, gamma, value);
    if norm(oldpolicy - policy, Inf) == 0
        break;
    end
    oldpolicy = policy;
end
toc

valuePI = value;
policyPI = policy;

save PI.mat policyPI valuePI