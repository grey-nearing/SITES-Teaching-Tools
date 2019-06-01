% function [densities,edges] = hist1_fixed_sample(X,nBins)

X = rand(10,1);
nBins = 3;


% number of samples
[N,D] = size(X);
assert(D==1)

% determine bin edges
E = round(linspace(0,1,nBins+1)*N);
[Xsort,Isort] = sort(X);   % sorted values

% edge buffer
Xbuffer = max(1e-6,min(diff(X)));

% init storage
densities = zeros(nBins,1)./0;
edges = zeros(nBins+1,1)./0;
edges(1) = Xsort(1) - Xbuffer;

for e = 2:nBins
    edges(e) = Xsort(E(e)) + Xbuffer;
end % e-loop

edges(end) = Xsort(end) + Xbuffer;

