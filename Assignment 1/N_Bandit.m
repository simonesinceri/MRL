% Assignment 1 -> n-armed Bandit

clc
clear all
close all

% Modello

T = 100;
n = 10;
%epsilon = 0.3; % eventuale for per paragonare i vari epsilon

mu = ones(T+1,n); % medie iniziali
sigma = 0.5*ones(1,n);% varianze

R = zeros(T,n);

for i=1:T
    
    R(i,:) = normrnd(mu(i), sigma,1,10);
   % mu(i+1,:) = randi([-1 1],1,10); % ????
    mu(i+1,:) = rand(1,10)-rand(1,10);
    
end

% vari metodi
%% Sample Average Method (alpha 1/k)

Nt = zeros(1,n);
Qt = zeros(T+1,n);
%Qt = zeros(1,n);

averageRew1 = zeros(1,T);
sumRew = 0;

epsilon = 0.3;
percent = zeros(1,T);
for i=1:T
    
    if(rand < epsilon)
        a = randi(10);
    else
       % a = find(Qt == max(Qt),1);
       a = find(Qt(i,:) == max(Qt(i,:)),1);
    end
    sumRew = sumRew + R(a);
    averageRew1(i) = sumRew/i;
    
    ottim = find(mu(i,:) == max(mu(i,:)),1);
    percent(i) = (Qt(a)/mu(ottim))*100;
    
    Nt(a) = Nt(a) + 1;
    Qt(i,a) = Qt(i,a) + 1/Nt(a)*(R(i,a)-Qt(i,a));
    %Qt(a) = Qt(a) + 1/Nt(a)*(R(i,a)-Qt(a))
    Qt(i+1,:) = Qt(i,:);
end

% figure(1)
% title("Average Reward")
% plot(averageRew1)
% 
% figure(2)
% hold on
% plot(mu(:,1))
%%
figure(3)
hold on
plot(Qt(1:end-1,1))
plot(mu(1:end-1,1))
legend('Qt','mu')

figure()
plot(percent)
%% Sample Average Method (alpha cost)

alpha = 0.5;

Nt = zeros(1,n);
Qt = zeros(T+1,n);
averageRew2 = zeros(1,T);
sumRew = 0;
epsilon = 0.1;

for i=1:T
    
    if(rand < epsilon)
        a = randi(10);
    else
       % a = find(Qt == max(Qt),1);
       a = find(Qt(i,:) == max(Qt(i,:)),1);
    end
    sumRew = sumRew + R(a);
    averageRew2(i) = sumRew/i;
    
    Nt(a) = Nt(a) + 1;
    Qt(i,a) = Qt(i,a) + 1/alpha*(R(i,a)-Qt(i,a));
    %Qt(a) = Qt(a) + 1/Nt(a)*(R(i,a)-Qt(a))
    Qt(i+1,:) = Qt(i,:);
end

%% Upper Confidence Bound method (UCB)

alpha = 0.5;

Nt = zeros(1,n);
Qt = 100*zeros(T+1,n);

averageRew3 = zeros(1,T);
sumRew = 0;

c = 0.5;

for i=1:T
    
    ln = log(i)*ones(1,n);
    Ucb = Qt(i,:) + c*sqrt(ln/Nt); % calcolo tutto il vettore delgi Ucb
    a = find(Ucb == max(Ucb),1);
    % a = find(Qt == max(Qt),1);
    %a = find(Qt(i,:) == max(Qt(i,:)),1);
    
    sumRew = sumRew + R(a);
    averageRew3(i) = sumRew/i;
    
    Nt(a) = Nt(a) + 1;
    Qt(i,a) = Qt(i,a) + 1/alpha*(R(i,a)-Qt(i,a));
    %Qt(a) = Qt(a) + 1/Nt(a)*(R(i,a)-Qt(a))
    Qt(i+1,:) = Qt(i,:);
end

%% Preference Based  Action Selection method

alpha = 0.5;

H = zeros(1,n); % vettore preferenze
% posso fare una matrice, se voglio vedere l'andamento di qst nel tempo
pi_t = zeros(1,n);
averageRew4 = zeros(1,T);
sumRew = 0;

for i=1:T
   
    sumH = sum(exp(H));
   for k=1:n
       pi_t(k) = exp(H(k))/sumH;
   end
   
   a = find(H == max(H),1);
   sumRew = sumRew + R(a);
   averageRew4(i) = sumRew/i;
   % aggiornamento H
   for j=1:n
       if(j == a)
           H(j) = H(j) + alpha*(R(a) - averageRew4(i))*(1 - pi_t(j));
       else
          H(j) = H(j) - alpha*(R(a) - averageRew4(i))*(pi_t(j)); 
       end
   end
end

%% Grafici

figure('Name','Average Reward','NumberTitle','off')
%title('Average Reward')
hold on

plot(averageRew1);
plot(averageRew2);
plot(averageRew3);
plot(averageRew4);
legend('alpha 1/k','alpha cost','UCB','Prefer')
% 
% subplot(1,4,1)
% plot(averageRew1);
% title('alpha 1/k')
% subplot(1,4,2)
% plot(averageRew2);
% title('alpha cost')
% subplot(1,4,3)
% plot(averageRew3);
% title('UCB')
% subplot(1,4,4)
% plot(averageRew4);
% title('Prefereces');




