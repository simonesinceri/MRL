%% Non-stationary problem with action-values methods using preferences gradient
clc
clear 
close all

alpha = 0.1;
iter = 1e5;
episodes = 50;
BA_array = zeros(1,iter);
R_avg = zeros(1,iter);
for j = 1:episodes
    H = ones(1,10) * 10;
    Rtot = 0; best_actions = 0;
    q = normrnd(0,10,1,10); %vettore che tiene conto di q
    for i=1:iter
        %calcolo probabilità
        expH = exp(H);
        P = expH/(sum(expH));
        %scelta dell'azione
        a = randsample(length(P),1,true,P);
        [~, a_best] = max(q);
        if q(a) == q(a_best)
            best_actions = best_actions + 1;
        end
        BA_array(i) = BA_array(i) + 100*best_actions / i;
        %genero ricompensa
        R = normrnd(q(a),1);
        Rtot = Rtot + R;
        R_avg(i) = R_avg(i) + Rtot / i;
        %apprendimento
        H_temp = H(a);
        H = H - alpha*(R - (Rtot - R)/max(i-1,1))*P;
        H(a) = H_temp + alpha*(R - (Rtot - R)/max(i-1,1))*(1 - P(a));
        %q* fa random walks ogni tot passi
        if mod(i,1) == 0
            q = q + 0.01*normrnd(0,10,1,10);
        end
    end
end
R_avg = R_avg / episodes;
BA_array = BA_array / episodes;

save preferences_gradient_data_p.mat R_avg BA_array
