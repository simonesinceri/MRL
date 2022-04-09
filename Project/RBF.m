function x = RBF(s, a, sigma, gridx,M, N, A)

nCells = (M + 1);
d = A*N*nCells;
x = zeros(d, 1);
% M numero celle
% N numero griglie
% dovrebbe usare intersezione griglie come pti centro RBF

% considero ciascun punto x della griglia
for i1 = 1 : N % per ogni griglia
    for i2 = 1 : M+1
            ind = sub2ind([M+1 N A], i2, i1, a);
            x(ind) = exp((-1/sigma^2)*norm(s(2) - gridx(i1,i2))^2);
    end
end


end