function sample = sample_copula_density(jointDensity,nSamples)
% Samples a constructed copula function with kernel density marginals

% construct copula covariance matrix:
R = eye(2);
R(1,2) = jointDensity.param;
R(2,1) = R(1,2);

% pull inverse cdf samples:
Usample = randn(nSamples,2)*chol(R);

% standard normal cdf of each sample:
Usample(:,1) = cdf('norm',Usample(:,1),0,1);
Usample(:,2) = cdf('norm',Usample(:,2),0,1);

% get pdf of each marginal:
[X1,marginalPDF1] = plot_mixture_density(jointDensity.marginal1);
[X2,marginalPDF2] = plot_mixture_density(jointDensity.marginal2);

% sort pdfs:
[X1,i1] = sort(X1); marginalPDF1 = marginalPDF1(i1);
[X2,i2] = sort(X2); marginalPDF2 = marginalPDF2(i2);

% get cdf of each marginal:
marginalCDF1 = cumsum(marginalPDF1) / sum(marginalPDF1);
marginalCDF2 = cumsum(marginalPDF2) / sum(marginalPDF2);

% init storage:
sample = zeros(nSamples,2)./0;

% linear interp between sampled cdfs:
for s = 1:nSamples
    
    while any(isnan(sample(s,2)))
        
        try
            u = Usample(s,1);
            imin = find(u > marginalCDF1,1,'last');
            imax = find(u < marginalCDF1,1,'first');
            assert(imax-imin == 1)
            
            cmin = marginalCDF1(imin);
            cmax = marginalCDF1(imax);
            xfrac = (u-cmin) / (cmax-cmin);
            sample(s,1) = X1(imin) + xfrac * (X1(imax) - X1(imin));
            
            u = Usample(s,2);
            imin = find(u > marginalCDF2,1,'last');
            imax = find(u < marginalCDF2,1,'first');
            assert(imax-imin == 1)
            
            cmin = marginalCDF2(imin);
            cmax = marginalCDF2(imax);
            xfrac = (u-cmin) / (cmax-cmin);
            sample(s,2) = X2(imin) + xfrac * (X2(imax) - X2(imin));
        
        catch
            
            % reset sample values:
            sample(s,:) = 0/0;
            
            % pull a new sample:
            Unew = randn(nSamples,2)*chol(R);
            Usample(s,1) = cdf('norm',Unew(s,1),0,1);
            Usample(s,2) = cdf('norm',Unew(s,2),0,1);
            
        end % make sure sample cdf is in bounds
        
    end
end

