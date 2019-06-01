function [counts,edges] = hist2(X,nBins)

% number of samples
[N,D] = size(X);
assert(D==2)

% set edges
Xbuffer = min(1e-6,1e-6*std(X(:,1)));
Xmin = min(X(:,1)) - Xbuffer;
Xmax = max(X(:,1)) + Xbuffer;
Xedges = linspace(Xmin,Xmax,nBins+1)';

Ybuffer = min(1e-6,1e-6*std(X(:,2)));
Ymin = min(X(:,2)) - Ybuffer;
Ymax = max(X(:,2)) + Ybuffer;
Yedges = linspace(Ymin,Ymax,nBins+1)';

% init storage
counts = zeros(nBins,nBins);

% place samples in bins
for n = 1:N
  x = find(X(n,1) >= Xedges,1,'last');
  y = find(X(n,2) >= Yedges,1,'last');
  counts(x,y) = counts(x,y) + 1;
end

% store edges for output
edges = [Xedges(:),Yedges(:)];

% check that all samples are accounted for
assert(sum(counts(:)) == N)








