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
A = 4;
%A = 8; % per windyKings

%wind = [0 0 0 1 1 1 2 2 1 0];

xtarget = 8;
ytarget = 4;

starget = sub2ind([nx ,ny], xtarget, ytarget);

%update = @(s,a) windy(s, a, nx, ny, wind);

Q = zeros(S, A);
sumrew = 0;
figure()
for i = 1:numEpisodes
    s = sub2ind([nx ,ny], 2, 2);
    traj = s;
    rew = 0;
    while s ~= starget
        a = epsGreedy(Q(s,:), epsilon);
        wind = randi([-1 1],1,nx);
        %[sp, r] = update(s, a);
        [sp, r] = windy(s, a, nx, ny, wind);
        %[sp, r] = windyKings(s, a, nx, ny, wind);
        traj = [traj, sp];
        apGreedy = find(Q(sp,:) == max(Q(sp, :)), 1, 'first');
        probP = epsilon/A*ones(1,A);
        probP(apGreedy) = probP(apGreedy) + 1 - epsilon;
        Qp = sum(Q(sp, :).*probP);
        Q(s,a) = Q(s,a) + alpha*(r + gamma*Qp - Q(s,a));
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