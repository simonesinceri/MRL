clear all
close all
clc

nx = 10;
ny = 6;

numEpisodes = 1e4;
epsilon = 0.1;
alpha = 0.1;
gamma = 1;

S = nx*ny;
%A = 4;
A = 8; % per windyKings

%wind = [0 0 0 1 1 1 2 2 1 0];

xtarget = 8;
ytarget = 4;

starget = sub2ind([nx ,ny], xtarget, ytarget);

%update = @(s,a) windy(s, a, nx, ny, wind);

Q1 = zeros(S, A);
Q2 = zeros(S, A);
sumrew = 0;
figure()
for i = 1:numEpisodes
    s = sub2ind([nx ,ny], 2, 2);
    traj = s;
    rew = 0;
    while s ~= starget
        Q = 1/2*(Q1 + Q2);
        a = epsGreedy(Q(s,:), epsilon);
        wind = randi([-1 1],1,nx);
        %[sp, r] = update(s, a);
        %[sp, r] = windy(s, a, nx, ny, wind);
        [sp, r] = windyKings(s, a, nx, ny, wind);
        traj = [traj, sp];
        if rand < 0.5
            apmax = find(Q1(sp,:) == max(Q1(sp,:)), 1, 'first');
            Qp = Q2(sp, apmax);
            Q1(s,a) = Q1(s,a) + alpha*(r + gamma*Qp - Q1(s,a));
        else
            apmax = find(Q2(sp,:) == max(Q2(sp,:)), 1, 'first');
            Qp = Q1(sp, apmax);
            Q2(s,a) = Q2(s,a) + alpha*(r + gamma*Qp - Q2(s,a));
        end
        s = sp;
        rew = rew + r;
    end
    sumrew = (sumrew + rew)/i;

    if mod(i,100) == 0
        display(i)
        display(sumrew)
        clf
        [xx, yy] = ind2sub([nx ,ny], traj);
        plot(xx,yy)
        xlim([1, nx])
        ylim([1, ny])
        pause(1)
    end
end