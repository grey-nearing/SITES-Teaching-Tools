function Xicdf = probability_integral_transform(X)

N = length(X);
[~,rank] = sort(X);
[~,rank] = sort(rank);
Xicdf = (rank-1) / (N-1);

