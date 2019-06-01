function [counts,Xedges] = hist1(X,nBins)

% number of samples
N = length(X);

% set edges
Xbuffer = min(1e-6,1e-6*std(X));
Xmin = min(X) - Xbuffer;
Xmax = max(X) + Xbuffer;
Xedges = linspace(Xmin,Xmax,nBins+1)';

% init storage
counts = zeros(nBins,1);

% place samples in bins
for n = 1:N
  x = find(X(n) >= Xedges,1,'last');
  counts(x) = counts(x) + 1;
end

% check that all samples are accounted for
assert(sum(counts(:)) == N)






