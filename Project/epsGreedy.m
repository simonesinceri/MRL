function a = epsGreedy(s, w, eps, gridx, M, N, A)

if rand < eps   % azione random
    a = randi(A);
else
    q = zeros(A, 1);
    for a = 1:A  % valuto tutte le azioni che posso prendere
        q(a) = w'*features(s, a, gridx, M, N, A); % approsimazione della funz qualità
    end        % pesi per vett features
    a = find(q == max(q), 1, 'first'); % scelgo quella con funz qualità massima
end
%display(q(a))
end