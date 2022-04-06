% Assignment 1 -> n-armed Bandit

% Parlare al prof dell'eventuale grafico dell'andamento stime media vs
% media vera -> altrimenti tolgo Q come matrice e mantengo solo vettore
clc
clear all
close all

T = (1e6);
n = 10;

epsilon = 0.1; % eventuale for per paragonare i vari epsilon
alpha = 0.1;

load bandit_R_mu_10e6.mat
%load bandit_R_mu_10e6_DETERMINISTIC.mat 
%load bandit_R_mu_10e6_DETERMINISTIC_UGUALI1.mat

%% Sample Average Method (alpha 1/k)

Nt = zeros(1,n);
Qt = zeros(T+1,n);
%Qt = zeros(1,n);

averageRew1 = zeros(1,T);
sumRew = 0;
%epsilon = 0.5;
BA = 0;
BA_avg1 = zeros(1,T);
for i=1:T
    
    if(rand < epsilon)
        a = randi(10);
    else
        %5a = find(Qt == max(Qt),1);
        a = find(Qt(i,:) == max(Qt(i,:)),1);
    end
    sumRew = sumRew + R(a);
    averageRew1(i) = sumRew/i;
    
    ottim = find(mu(i,:) == max(mu(i,:)),1);
    %percent(i) = (Qt(a)/mu(ottim))*100; % percentuale dell'ottimalitàa della azione scelta
    if(a == ottim)
        BA = BA + 1;
    end
    BA_avg1(i) = (BA/i)*100;
    % percentuale di azioni ottime prese vs tempo
    
    % aggiornamento non mi torna, dovrebbe essere giusto
    Nt(a) = Nt(a) + 1;
    Qt(i,a) = Qt(i,a) + 1/Nt(a)*(R(i,a)-Qt(i,a));
    %Qt(a) = Qt(a) + 1/Nt(a)*(R(i,a)-Qt(a));
    Qt(i+1,:) = Qt(i,:);
end

% figure(1)
% title("Average Reward")
% plot(averageRew1)
% 
% figure(2)
% hold on
% plot(mu(:,1))
%% Plot andamento medie/stime delle medie
figure('Name','Stima VS Media vera','NumberTitle','off')
hold on
plot(mu(1:end-1,1))
plot(Qt(1:end-1,1))
%legend('Qt','mu')
% 
% figure()
% plot(BA_avg1) 
%% Sample Average Method (alpha cost)

Nt = zeros(1,n);
Qt = zeros(T+1,n);
averageRew2 = zeros(1,T);
sumRew = 0;
%epsilon = 0.3;
BA = 0;
BA_avg2 = zeros(1,T);

for i=1:T
    
    if(rand < epsilon)
        a = randi(10);
    else
       % a = find(Qt == max(Qt),1);
       a = find(Qt(i,:) == max(Qt(i,:)),1);
    end
    sumRew = sumRew + R(a);
    averageRew2(i) = sumRew/i;
    
    ottim = find(mu(i,:) == max(mu(i,:)),1);
    if(a == ottim)
        BA = BA + 1;
    end
    BA_avg2(i) = (BA/i)*100;
    
    Nt(a) = Nt(a) + 1;
    Qt(i,a) = Qt(i,a) + alpha*(R(i,a)-Qt(i,a));
    %Qt(a) = Qt(a) + 1/Nt(a)*(R(i,a)-Qt(a))
    Qt(i+1,:) = Qt(i,:);
end




%%
hold on
plot(Qt(1:end-1,1))
%% Upper Confidence Bound method (UCB)

% mi prende sempre e solo la prima azione ???
Nt = 0.01*ones(1,n); % invece di tutti zeros
Qt = 10*ones(T+1,n);
%Qt = 10*ones(1,n);

averageRew3 = zeros(1,T);
sumRew = 0;

c = 1;
BA = 0;
BA_avg3 = zeros(1,T);

for i=1:T
   
    ln = log(i).*ones(1,n);
    exploration = c*sqrt(ln./Nt);
    Ucb = Qt(i,:) + exploration;  % calcolo tutto il vettore delgi Ucb
   % Ucb = Qt + exploration;
    a = find(Ucb == max(Ucb),1);
    % a = find(Qt == max(Qt),1);
    %a = find(Qt(i,:) == max(Qt(i,:)),1);
    
    sumRew = sumRew + R(a);
    averageRew3(i) = sumRew/i;
    
    ottim = find(mu(i,:) == max(mu(i,:)),1);
    if(a == ottim)
        BA = BA + 1;
    end
    BA_avg3(i) = (BA/i)*100;
    % mi riporta i Qt a 10 ?? dato da Qt(i,a) dovrei avere Qt(i-1)+ ..
    Nt(a) = Nt(a) + 1;
    Qt(i,a) = Qt(i,a) + alpha*(R(i,a)-Qt(i,a));
    %Qt(a) = Qt(a) + 1/Nt(a)*(R(i,a)-Qt(a));
    Qt(i+1,:) = Qt(i,:);
end

% % Plot UCB per vari c     
% figure(3)
% hold on 
% plot(averageRew3)
% 
% figure(4)
% hold on 
% plot(BA_avg3)
% 
% legend('1','2','3','4','5')
%%
hold on
plot(Qt(1:end-1,1))
%% Preference Based  Action Selection method    

H = ones(1,n)*10; % vettore preferenze
% posso fare una matrice, se voglio vedere l'andamento di qst nel tempo
pi_t = zeros(1,n);
averageRew4 = zeros(1,T);
sumRew = 0;

BA = 0;
BA_avg4 = zeros(1,T);

for i=1:T
 %for i=1:30   
    expH = exp(H);
    pi_t = expH/sum(expH);
    
    a = randsample(length(pi_t),1,true,pi_t);
    
    sumRew = sumRew + R(a);
    averageRew4(i) = sumRew/i;
    
    ottim = find(mu(i,:) == max(mu(i,:)),1);
    if(a == ottim)
        BA = BA + 1;
    end
    BA_avg4(i) = (BA/i)*100;
    
    % aggiornamento H
    Ht = H(a);
    H = H - alpha*(R(a) - averageRew4(i))*(pi_t);
    H(a) = Ht + alpha*(R(a) - averageRew4(i))*(1 - pi_t(a));
    
end
%%
hold on
plot(Qt(1:end-1,1))

legend('mu','alpha 1/k','alpha cost','UCB','Prefer')
%% Grafici

figure('Name','Average Reward','NumberTitle','off')
%title('Average Reward')
hold on
ylabel('Average Reward')
plot(averageRew1);
plot(averageRew2);
plot(averageRew3);
plot(averageRew4);
xlim([-T/100 T])
legend('alpha 1/k','alpha cost','UCB','Prefer')

figure('Name','Quality','NumberTitle','off')
%title('Average Reward')


hold on 

plot(BA_avg1);
plot(BA_avg2);
plot(BA_avg3);
plot(BA_avg4);
xlim([-T/100 T])
legend('alpha 1/k','alpha cost','UCB','Prefer')
ylabel('Quality')
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




