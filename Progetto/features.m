% Dato uno stato(pos,vel) vogliamo trovare le features
% anche azioni perchè stiamo facendo controllo

function x = features(s, a, gridx, M, N, A)

% numero celle, +1 perchè ne ho aggiunta una
nCells = (M + 1); % dimensione features per una cella
d = A*N*nCells; % dimensione vettore pesi da aggiornare
x = zeros(d, 1);

for ii = 1 : N
    xxx = gridx(ii, :);  % attenzione al formato di s STATO %%%%%%%%
    
    % capire in quale cella mi trovo, trovo indice lungo x
    ix = find(s(2) >= xxx(1:end-1) & s(2) <= xxx(2:end), 1, 'first');
    
    ind = sub2ind([M + 1, N, A], ix, ii, a);
    x(ind) = 1; % valore corrispondente alla cella
    % vett features ha un 1 per ogni griglia

end