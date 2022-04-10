%% Plot dei vari metodi
clc
clear
close all
set(0,'DefaultFigureWindowStyle','docked')

%% Sample average method graphs for different value of epsilon
load 003sample_average_data.mat R_avg BA_array
figure(1);
hold on;
plot(1:length(R_avg),R_avg);
figure(2);
hold on;
plot(1:length(R_avg),BA_array);

load 005sample_average_data.mat R_avg BA_array
figure(1);
hold on;
plot(1:length(R_avg),R_avg);
figure(2);
hold on;
plot(1:length(R_avg),BA_array);

load 01sample_average_data.mat R_avg BA_array
figure(1);
hold on;
plot(1:length(R_avg),R_avg);
figure(2);
hold on;
plot(1:length(R_avg),BA_array);

load 015sample_average_data.mat R_avg BA_array
figure(1);
hold on;
plot(1:length(R_avg),R_avg);
figure(2);
hold on;
plot(1:length(R_avg),BA_array);

figure(1)
title("Reward Sample Average")
xlabel("time")
ylabel("reward")
legend(char(949) + "= 0.03", char(949) + "= 0.05", char(949) + "= 0.10", char(949) + "= 0.15")
figure(2)
title("Quality Sample Average")
xlabel("time")
ylabel("% best actions")
legend(char(949) + "= 0.03", char(949) + "= 0.05", char(949) + "= 0.10", char(949) + "= 0.15")

%% Constant step size method graphs for different value of epsilon
load 003constant_stp_size_data.mat R_avg BA_array
figure(3);
hold on;
plot(1:length(R_avg),R_avg);
figure(4);
hold on;
plot(1:length(R_avg),BA_array);

load 005constant_stp_size_data.mat R_avg BA_array
figure(3);
hold on;
plot(1:length(R_avg),R_avg);
figure(4);
hold on;
plot(1:length(R_avg),BA_array);

load 01constant_stp_size_data.mat R_avg BA_array
figure(3);
hold on;
plot(1:length(R_avg),R_avg);
figure(4);
hold on;
plot(1:length(R_avg),BA_array);

load 015constant_stp_size_data.mat R_avg BA_array
figure(3);
hold on;
plot(1:length(R_avg),R_avg);
figure(4);
hold on;
plot(1:length(R_avg),BA_array);

figure(3)
title("Reward Constant Step Size")
xlabel("time")
ylabel("reward")
legend(char(949) + "= 0.03", char(949) + "= 0.05", char(949) + "= 0.10", char(949) + "= 0.15")
figure(4)
title("Quality Constant Step Size")
xlabel("time")
ylabel("% best actions")
legend(char(949) + "= 0.03", char(949) + "= 0.05", char(949) + "= 0.10", char(949) + "= 0.15")

%% UCB method graphs for different value of c
load 05UCB_data.mat R_avg BA_array
figure(5);
hold on;
plot(1:length(R_avg),R_avg);
figure(6);
hold on;
plot(1:length(R_avg),BA_array);

load 07UCB_data.mat R_avg BA_array
figure(5);
hold on;
plot(1:length(R_avg),R_avg);
figure(6);
hold on;
plot(1:length(R_avg),BA_array);

load 1UCB_data.mat R_avg BA_array
figure(5);
hold on;
plot(1:length(R_avg),R_avg);
figure(6);
hold on;
plot(1:length(R_avg),BA_array);

load 10UCB_data.mat R_avg BA_array
figure(5);
hold on;
plot(1:length(R_avg),R_avg);
figure(6);
hold on;
plot(1:length(R_avg),BA_array);

load 15UCB_data.mat R_avg BA_array
figure(5);
hold on;
plot(1:length(R_avg),R_avg);
figure(6);
hold on;
plot(1:length(R_avg),BA_array);

load 18UCB_data.mat R_avg BA_array
figure(5);
hold on;
plot(1:length(R_avg),R_avg);
figure(6);
hold on;
plot(1:length(R_avg),BA_array);

figure(5)
title("Reward UCB")
xlabel("time")
ylabel("reward")
legend("c = 05", "c = 07", "c = 1", "c = 10", "c = 15", "c = 18")
figure(6)
title("Quality UCB")
xlabel("time")
ylabel("% best actions")
legend("c = 05", "c = 07", "c = 1", "c = 10", "c = 15", "c = 18")


%% Confronto
load 003sample_average_data.mat R_avg BA_array
figure(7);
hold on;
plot(1:length(R_avg),R_avg);
figure(8);
hold on;
plot(1:length(R_avg),BA_array);

load 003constant_stp_size_data.mat R_avg BA_array
figure(7);
hold on;
plot(1:length(R_avg),R_avg);
figure(8);
hold on;
plot(1:length(R_avg),BA_array);

load 15UCB_data.mat R_avg BA_array
figure(7);
hold on;
plot(1:length(R_avg),R_avg);
figure(8);
hold on;
plot(1:length(R_avg),BA_array);

load preferences_gradient_data.mat R_avg BA_array
figure(7);
hold on;
plot(1:length(R_avg),R_avg);
figure(8);
hold on;
plot(1:length(R_avg),BA_array);

figure(7);
title("Reward")
xlabel("time");
ylabel("average reward");
legend("Sample average", "Constant step size", "UCB", "Preferences gradient");
figure(8);
title("Quality")
xlabel("time");
ylabel("percentage best action");
legend("Sample average", "Constant step size", "UCB", "Preferences gradient");

%% Confronto stazionario , senza random walks nelle medie
load 003sample_average_data_cost.mat R_avg BA_array
figure(9);
hold on;
plot(1:length(R_avg),R_avg);
figure(10);
hold on;
plot(1:length(R_avg),BA_array);

load 003constant_stp_size_data_cost.mat R_avg BA_array
figure(9);
hold on;
plot(1:length(R_avg),R_avg);
figure(10);
hold on;
plot(1:length(R_avg),BA_array);

load 15UCB_data_cost.mat R_avg BA_array
figure(9);
hold on;
plot(1:length(R_avg),R_avg);
figure(10);
hold on;
plot(1:length(R_avg),BA_array);

load preferences_gradient_data_cost.mat R_avg BA_array
figure(9);
hold on;
plot(1:length(R_avg),R_avg);
figure(10);
hold on;
plot(1:length(R_avg),BA_array);

figure(9);
title("Reward")
xlabel("time");
ylabel("average reward");
legend("Sample average", "Constant step size", "UCB", "Preferences gradient");
figure(10);
title("Quality")
xlabel("time");
ylabel("percentage best action");
legend("Sample average", "Constant step size", "UCB", "Preferences gradient");

%% Confronto senza episodi
load 003sample_average_data_p.mat R_avg BA_array
figure(11);
hold on;
plot(1:length(R_avg),R_avg);
figure(12);
hold on;
plot(1:length(R_avg),BA_array);

load 003constant_stp_size_data_p.mat R_avg BA_array
figure(11);
hold on;
plot(1:length(R_avg),R_avg);
figure(12);
hold on;
plot(1:length(R_avg),BA_array);

load 15UCB_data_p.mat R_avg BA_array
figure(11);
hold on;
plot(1:length(R_avg),R_avg);
figure(12);
hold on;
plot(1:length(R_avg),BA_array);

load preferences_gradient_data_p.mat R_avg BA_array
figure(11);
hold on;
plot(1:length(R_avg),R_avg);
figure(12);
hold on;
plot(1:length(R_avg),BA_array);

figure(11);
title("Reward")
xlabel("time");
ylabel("average reward");
legend("Sample average", "Constant step size", "UCB", "Preferences gradient");
figure(12);
title("Quality")
xlabel("time");
ylabel("percentage best action");
legend("Sample average", "Constant step size", "UCB", "Preferences gradient");