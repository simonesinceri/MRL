% Assignment 3 -> Driving a race car around a turn
% Monte Carlo methods
% A = 3; %+-1 e 0
% dimX = 20;
% dimY =20;

%devo mappare posizioni ammisibili, partenza e finali

% simula il modello    
function [sp, r] = run(s,a)
%sp -> stato successivo, r->ricompensa

[x,y,x_p,y_p]= ind2sub([20 20 11 11],s); % stato di partenza
[a_x,a_y] = ind2sub([3 3],a);

% range velocità da -5 a +5
x_p = x_p - 1 - 5;
y_p = y_p - 1 - 5;

% max/min su posizioni e velocità fuori range
%saturazioni
% 1->0, 2 ->+1, 3->-1
if(a_x == 2)
    x_p = x_p + 1;
end
if(a_x == 3)
    x_p = x_p - 1;
end

if(a_y == 2)
    y_p = y_p + 1;
end
if(a_y == 3)
    y_p = y_p - 1;
end

x_p = min(max(x_p,-5),5);
y_p = min(max(y_p,-5),5);

x = max(min(x + x_p,20),1); %aggiorno posizione
y = max(min(y + y_p,20),1);

x_p = x_p + 1 + 5;
y_p = y_p + 1 + 5;                                                           
% 1            %2                 %3   punti fuori pista
if(y<=5 ||  x<=5 || (x>10 && y>15))
    r = -10000;
    sp = -1;
    
elseif((x>5 && x<10) && y == 20) % linea traguardo
    r = 0;
    sp = -1;
    
else  % all'interno pista
    r = -1;
    sp = sub2ind([20 20 11 11],x,y,x_p,y_p);
    
end

end