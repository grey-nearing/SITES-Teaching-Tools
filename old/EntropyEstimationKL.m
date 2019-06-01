function E = EntropyEstimationKL(X)
% Kozachenko-Leonenko entropy estimation

% dimensions
n = length(X);

%distance to the nearest neighbour
X = sort(X);
r = zeros(1,n);
r(1) = X(2)-X(1);
r(2:end-1) = min(X(3:n) - X(2:n-1), X(2:n-1) - X(1:n-2)); %looking for the nearest neighbour
r(n) = X(n)-X(n-1);
r(r==0) = 1/sqrt(n); % denegerate values

% actual estimation
E = (1/n)*sum(log(r))+log(2*(n-1))+0.5772156649;