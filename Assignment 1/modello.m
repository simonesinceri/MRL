% Genero dati modello N-Bandit, ricompense e andamento delle mesie
clc
clear all
close all

% Modello

T = 50*(1e6);
n = 10;
%epsilon = 0.3; % eventuale for per paragonare i vari epsilon

mu = ones(T+1,n);  % partono tutte con stessa media = 1
%mu(1,:) = normrnd(0,10,1,10);% medie iniziali
%mu(1,:) = normrnd(0,1,1,10);

sigma = 0.5*ones(1,n);% varianze

R = zeros(T,n);
% genero ricompense
for i=1:T
    i
    R(i,:) = normrnd(mu(i), sigma,1,10);
                                      % occhio alla varianza qui 
    %mu(i+1,:) = mu(i,:) + 0.001*normrnd(0,10,1,10); % prova 0.1
    mu(i+1,:) = mu(i,:)+ 0.1*normrnd(0,1,1,10);

end

save bandit_R_mu_10e6_1.mat R mu