function E = knn_entropy(X)

% dimensions
n = length(X);

% calculation
E = (1/(n-1))*sum(log(diff(sort(X)))) + psi(n) - psi(1);