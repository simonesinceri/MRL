function [sp, r] = windyKings(s, a, nx, ny, wind)

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
    case 5
        xp = max(x - 1, 1);
        yp = min(y + 1, ny);
    case 6
        xp = min(x + 1, nx);
        yp = min(y + 1, ny);
    case 7
        xp = max(x - 1, 1);
        yp = max(y - 1, 1);
    case 8
        xp = min(x + 1, nx);
        yp = max(y - 1, 1);
end

yp = max(min(yp + wind(x), ny),1);

sp = sub2ind([nx ,ny], xp, yp);
r = -1;