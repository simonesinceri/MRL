% Assignment 3 -> Driving a race car around a turn
% Monte Carlo methods
% A = 3; %+-1 e 0
% dimX = 20;
% dimY =20;

%devo mappare posizioni ammisibili, partenza e finali

% simula il modello     a = [a_x, a_y]
function [sp, r] = run(s,a)  % devo mappare a come 1 2 3 +> 0 +1 -1
%sp -> stato successivo, r->ricompensa
[x,y,x_p,y_p]= ind2sub([20 20 11 11],s); % stato di partenza
[a_x,a_y] = ind2sub([3 3],a);

% range velocità da -5 a +5 
x_p = x_p - 1 - 5;
y_p = y_p - 1 - 5;

% max/min su posizioni e velocità fuori range
%saturazioni
if(a_x == 1) % 1->0, 2 ->+1, 3->-1
    x_p = min(x_p, 5); %agg velocità
elseif(a_x == 2)
    x_p = min(x_p + 1,5);
else
    x_p = min(x_p - 1,5);
end

if(a_y == 1)
    y_p = min(y_p ,5);
elseif(a_y == 2)
    y_p = min(y_p + 1,5);
else
    y_p = min(y_p - 1,5);
end

x_p = max(x_p,-5);
y_p = max(y_p,-5);

x = min(x + x_p,20); %aggiorno posizione
y = min(y + y_p,20);

x = max(x ,1);
y = max(y ,1);

x_p = x_p + 1 + 5;
y_p = y_p + 1 + 5;                                                           % devo codificare satto finale che se buco mi riporta sul traguardo
                                                                             % l'importante è che passo il traguuardo
%                                                                              % se supero limiti matrice devo rimappare all'interno


% 1            %2                 %3   punti fuori pista
if(y<=5 ||  x<=5 || (x>10 && y>15))
    r = -10000;
    sp = -1;
    %disp(1)
elseif((x>5 && x<10) && y == 20) % linea traguardo
    r = 0;
    sp = -1;
    %disp(2)
% elseif(x>20 || y >20 || x<1 || y<1) % fuori da mappa 20x20
%     r = -inf;
%     sp = -1;
%     %disp(3)
else  % all'interno pista
    r = -1;
    sp = sub2ind([20 20 11 11],x,y,x_p,y_p);
    %disp(4)
    
end

end