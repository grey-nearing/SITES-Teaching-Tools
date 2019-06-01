function [Ixy,Hx,Hy] = hist_info(X,Y,nBins)

% number of samples
[Nx,Dx] = size(X);
[Ny,Dy] = size(Y);
assert(Nx == Ny); N = Nx;

% set edges
Xedges = zeros(nBins+1,Dx);
Yedges = zeros(nBins+1,Dy);

for d = 1:Dx
    buffer = min(1e-6,1e-6*std(X(:,d)));
    Xedges(:,d) = linspace(min(X(:,d))-buffer,max(X(:,d))+buffer,nBins+1)';
end
for d = 1:Dy
    buffer = min(1e-6,1e-6*std(Y(:,d)));
    Yedges(:,d) = linspace(min(Y(:,d))-buffer,max(Y(:,d))+buffer,nBins+1)';
end

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

% densities
fx  = Px / (Xedges(2) - Xedges(1));
fy  = Py / (Yedges(2) - Yedges(1));
fxy = Pxy / (Xedges(2) - Xedges(1)) / (Yedges(2) - Yedges(1));

% calculate marginal entropies
Hx = -Px(Px>0)'*log(fx(Px>0));
Hy = -Py(Py>0)'*log(fy(Py>0));

% calcualate joint entropy
Hxy = -Pxy(Pxy>0)'*log(fxy(Pxy>0));

% calculate mutual information
Ixy = Hx+Hy-Hxy;






