% Costruisce la grigliatura
% grigliatura uniforme divido upper e lower bound in modo da avere 
% numero celle di uguale dimensione, devo agg ulteriore cella per poter
% fare spostamenti

function [gridx] = buildTiles(limSx, limDx, M, N)

off = 1; % offset 1 in una direzione
off = off./max(off); % devo normalizzare qst offset in modo che le mie
% griglie non escono dalla regione operativa
% un po starborda dato l'offset ma non mi interessa

dx = (limSx - limDx)/M; % qnt posso muovermi al massimo
TX = limDx - dx:dx:limSx; % Tiles su x, parto un dx prima
% aggiungo così una cella a SX in modo che dopo potrò fare l'offset di
% quanto mi serve

% costruisco le griglie lungo x 
gridx = zeros(N, length(TX)); % tante righe quante le griglie da generare

% prima riga già costruita pari a TX
gridx(1,:) = TX;

% succesive righe da offsettare di una piccola quantità
for ii = 2 : N
    gridx(ii, :) = TX + off*dx/N*(ii-1); % diviso num celle N ->sposto ogni griglia di un po
    % (ii-1) per non avere pezzi inutili fuori
end