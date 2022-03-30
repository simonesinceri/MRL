function [sp, r, isTerminal] = dynamics(s, a, limSx, limDx, y, passo,i)

% isTerminal non penso mi serva
yt = s(1); % stato attuale
xt = s(2);
at = a - 2; % azioni codificate come 1 2 3 -> -1 0 1

isTerminal = 0;

x_next = xt + at*passo;

dati = Road_Scenario(xt,yt,x_next,y*5,y,i);
sp = dati(end).ActorPoses.Position(1:2);
% Devo controllare se esco fuori dai limiti
sp(2) = min(sp(2),limSx);
sp(2) = max(sp(2),limDx); % lo riporta dentro ma nella simulazione si vede fuori forse

% Lateral distance Lane , attenzione quando ho un NaN bisogna gestirlo
if(y*5 ~= 30)
    d_lane = zeros(2,1);
    d_lane(1) = dati(end).LaneDetections.LaneBoundaries(1).LateralOffset; % [distSx(positiva),distDx(negativa)]
    d_lane(2) = dati(end).LaneDetections.LaneBoundaries(2).LateralOffset;

    ver = isnan(d_lane);
    %display(d_lane)
    % caso entrambe misure uguali a Nan o solo una
    if ((ver(1) + ver(2)) >= 1)
        r = -100;
    else
        r = -abs(round((d_lane(1) + d_lane(2)),3));
    end

else
    r = 0;
    isTerminal  = 1;
end
%display(r)
end
