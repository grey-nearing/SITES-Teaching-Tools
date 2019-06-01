function [Ixy,Hx,Hy] = mutual_info(X,Y,nBins)

% number of samples
N = size(X,1);
assert(size(Y,1) == N);

% set edges
Xbuffer = min(1e-6,1e-6*std(X));
Xmin = min(X) - Xbuffer;
Xmax = max(X) + Xbuffer;
Xedges = linspace(Xmin,Xmax,nBins+1)';

Ybuffer = min(1e-6,1e-6*std(Y));
Ymin = min(Y) - Ybuffer;
Ymax = max(Y) + Ybuffer;
Yedges = linspace(Ymin,Ymax,nBins+1)';

% init storage
counts = zeros(nBins);

% place samples in bins
for n = 1:N
  x = find(X(n) >= Xedges,1,'last');
  y = find(Y(n) >= Yedges,1,'last');
  counts(x,y) = counts(x,y) + 1;
end

% % this one is faster for large sample sizes
% for y = 2:nBins
%     I = find(Y <= Yedges(y) & Y > Yedges(y-1));
%     for x = 2:nBins
%         counts(x,y) = length(X(X(I) <= Xedges(x) & X(I) > Xedges(x-1)));
%     end
% end

% check that all samples are accounted for
assert(sum(counts(:)) == N)

% counts -> probability mass
Pxy = counts/N;

% marginalize over joint distribution
Px  = squeeze(sum(Pxy,2));
Py  = squeeze(sum(Pxy,1));

% reshape
Px = Px(:);
Py = Py(:);
Pxy = Pxy(:);

% make sure all samples are accounted for
try
    assert(abs(sum(Px)-1)  < 1/N^1.2)
    assert(abs(sum(Py)-1)  < 1/N^1.2)
    assert(abs(sum(Pxy)-1) < 1/N^1.2)
catch
    keyboard
end

% calculate marginal entropies
Hx = -Px(Px>0)'*log(Px(Px>0));
Hy = -Py(Py>0)'*log(Py(Py>0));

% calcualate joint entropy
Hxy = -Pxy(Pxy>0)'*log(Pxy(Pxy>0));

% calculate mutual information
Ixy = Hx+Hy-Hxy;






