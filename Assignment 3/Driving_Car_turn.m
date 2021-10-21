% Assignment 3 -> Driving a race car around a turn
% Monte Carlo methods
% A = 2; %+-1
% dimX = 20;
% dimY =20;

%devo mappare posizioni ammisibili, partenza e finali

% simula il modello
function [sp, r] = run(s,a)
%sp -> stato successivo, r->ricompensa
[x,y,x_p,y_p]= ind2sub([20 20 11 11],s); % stato di partenza
x = x - 1;
y = y - 1;
x_p = x_p - 1-5;
y_p = y_p - 1-5;

% max/min su posizioni e velocità fuori range
%saturazioni
x_p = min(x_p + a(1),5); %agg velocità
y_p = min(y_p +a(2),5);
% x_p = max(x_p,-5);
% y_p = max(y_p,-5);

x = x + x_p; %agg posizione
y = y + y_p;
% 1            %2                 %3   puti fuori mappa
if(y<=(5-1) ||  x<=(5-1) ||  ((x>(10-1))&&(y>(15-1))) )
    r = -1000;
    sp = -1;
elseif((x>(5-1) && x<(10-1)) && y == (20-1))
    r = 0;
    sp = -1;
elseif(x>(20-1) || y >(20-1) || x<0 || y<0)
    r = -1000;
    sp = -1;
else
    r = -1;
    sp = sub2ind([20 20 11 11],x,y,x_p,y_p);
    
end

end