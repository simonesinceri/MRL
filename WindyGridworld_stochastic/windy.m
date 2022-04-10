function [sp, r] = windy(s, a, nx, ny, wind)

[x, y] = ind2sub([nx ,ny], s);

switch a
    case 1
        xp = max(x - 1, 1);
        yp = y;
    case 2
        xp = min(x + 1, nx);
        yp = y;
    case 3
        xp = x;
        yp = max(y - 1, 1);
    case 4
        xp = x;
        yp = min(y + 1, ny);
    % caso king's mode azioni diventano 8
end

yp = max(min(yp + wind(x), ny),1);

sp = sub2ind([nx ,ny], xp, yp);
r = -1;