clear all
close all
clc

load data_tictactoe.mat
gamma = 0.5; % funziona con tutti valori di gamma

S = size(P,1);
A = size(R,2);

value = randn(S,1);
prevpolicy = randi(A,S,1);
prevValue = randn(S,1);

tic
while true
    [value, policy] = policyOptim(P, R, gamma, value);  
    if norm(value - prevValue) < 1e-3
        break;
    else
        prevValue = value;
    end
end
toc

valueVI = value;
policyVI = policy;