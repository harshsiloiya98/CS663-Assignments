function [U, S, V] = MySVD(A)

    [Uvec, Uval] = eig(A*A');
    [E, Uind] = sort(diag(Uval), 'descend');
    U = Uvec(:, Uind);
    
    [Vvec, Vval] = eig(A'*A);
    [~, Vind] = sort(diag(Vval), 'descend');
    V = Vvec(:, Vind);
    
    S = zeros(size(A));
    for i = 1:min(size(A))
        S(i,i) = sqrt(E(i));
        if (U(:,i)' * A * V(:,i) < 0)
            U(:,i) = -U(:,i);
        end
    end
    
end