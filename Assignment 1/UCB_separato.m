clc
clear all
close all

T = 1e6;
n = 10;


epsilon = 0.1; % eventuale for per paragonare i vari epsilon
alpha = 0.1;

load bandit_R_mu_10e6.mat

%% Upper Confidence Bound method (UCB)

c_vett = [0.5 1 5 10 15];
% mi prende sempre e solo la prima azione ???

averageRew3_vett = zeros(length(c_vett),T);
BA_avg3_vett = zeros(length(c_vett),T);

for ii=1:length(c_vett)

    Nt = 0.01*ones(1,n); % invece di tutti zeros
    Qt = 10*ones(T+1,n);



    %averageRew3 = averageRew3_vett(ii,:);
    sumRew = 0;

    c = c_vett(ii);
    BA = 0;
    %BA_avg3 = BA_avg3_vett(ii,:);

    for i=1:T

        ln = log(i).*ones(1,n);
        exploration = c*sqrt(ln./Nt);
        Ucb = Qt(i,:) + exploration;  % calcolo tutto il vettore delgi Ucb

        a = find(Ucb == max(Ucb),1);
        % a = find(Qt == max(Qt),1);
        %a = find(Qt(i,:) == max(Qt(i,:)),1);

        sumRew = sumRew + R(a);
        averageRew3_vett(ii,i) = sumRew/i;

        ottim = find(mu(i,:) == max(mu(i,:)),1);
        if(a == ottim)
            BA = BA + 1;
        end
        BA_avg3_vett(ii,i) = (BA/i)*100;
        % mi riporta i Qt a 10 ?? dato da Qt(i,a) dovrei avere Qt(i-1)+ ..
        Nt(a) = Nt(a) + 1;
        Qt(i,a) = Qt(i,a) + alpha*(R(i,a)-Qt(i,a));
        %Qt(a) = Qt(a) + 1/Nt(a)*(R(i,a)-Qt(a))
        Qt(i+1,:) = Qt(i,:);
    end
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
%% Grafici

figure('Name','Average Reward','NumberTitle','off')
%title('Average Reward')
hold on
ylabel('Average Reward vari UCB')
plot(averageRew3_vett(1,:));
plot(averageRew3_vett(2,:));
plot(averageRew3_vett(3,:));
plot(averageRew3_vett(4,:));
plot(averageRew3_vett(5,:));
xlim([-T/100 T])
legend('c = 0.5','c = 1','c = 10','c = 15')

figure('Name','Quality','NumberTitle','off')
%title('Average Reward')


hold on 
plot(BA_avg3_vett(1,:));
plot(BA_avg3_vett(2,:));
plot(BA_avg3_vett(3,:));
plot(BA_avg3_vett(4,:));
plot(BA_avg3_vett(5,:));
xlim([-T/100 T])
legend('c = 0.5','c = 1','c = 10','c = 15')
ylabel('Quality vari UCB')