function sample = sample_joint_density(jointDensity,nSamples)
% Samples a constructed copula function with kernel density marginals

% dimensions
nMarginals = length(jointDensity.marginal);

% construct copula covariance matrix:
R = jointDensity.copulaCovariance;

% init storage:
sample = zeros(nSamples,nMarginals)./0;

% pull inverse cdf samples:
Usample = randn(round(nSamples*1.4),nMarginals)*chol(R);
Usample(any(Usample' < icdf('norm',1e-4,0,1) | ...
    Usample' > icdf('norm',1-1e-4,0,1)),:) = [];
Usample = Usample(1:nSamples,:);

% standard normal cdf of each sample:
for m = 1:nMarginals

    % get pdf
    [X,marginalPDF] = plot_mixture_density(jointDensity.marginal{m});

    % pull inverse cdf samples
    Usample(:,m) = cdf('norm',Usample(:,m),0,1);        
        
    % get cdf
    [X,i] = sort(X); 
    marginalPDF = marginalPDF(i);
    marginalCDF = cumsum(marginalPDF) / sum(marginalPDF);
    
    % linear interp between sampled cdfs
    for s = 1:nSamples
%         while any(isnan(sample(s,:)))
%             try
                
                u = Usample(s,m);
                imin = find(u > marginalCDF,1,'last');
                imax = find(u < marginalCDF,1,'first');
                assert(imax - imin == 1)
                
                cmin = marginalCDF(imin);
                cmax = marginalCDF(imax);
                xfrac = (u-cmin) / (cmax-cmin);
                sample(s,m) = X(imin) + xfrac * (X(imax) - X(imin));
                
%             catch
%                 
%                 % reset sample values:
%                 sample(s,:) = 0/0;
%                 
%                 % pull a new sample:
%                 Unew = randn(nSamples,2)*chol(R);                
%                 for m1 = 1:nMarginals
%                     Usample(:,m1) = cdf('norm',Unew(:,m1),0,1);
%                 end
% 
%             end % make sure sample cdf is in bounds
%         end % make sure sample cdf is in bounds
    end% s-loop
end % m-loop

