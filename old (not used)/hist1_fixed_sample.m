function [densities,edges] = hist1_fixed_sample(X,nBins)

% number of samples
[N,D] = size(X);
assert(D==1)

% determine bin edges
E = unique(round(linspace(0,1,nBins+1)*N));
nBins = length(E)-1;
Xsort = sort(X);   % sorted values

% edge buffer
Xbuffer = max(1e-6,min(diff(X)));

% init storage
densities = zeros(nBins,1)./0;
edges = zeros(nBins+1,1)./0;

% find edges
try
    edges(1) = Xsort(1) - Xbuffer;
    for e = 2:nBins
        edges(e) = Xsort(E(e)) + Xbuffer;
    end % e-loop
    edges(end) = Xsort(end) + Xbuffer;
catch
    keyboard
end

% calculate densities
for b = 1:nBins
    count = length(find(X > edges(b) & X < edges(b+1)));
    prob = count / N;
    densities(b) = prob / (edges(b+1) - edges(b));
end % b-loop