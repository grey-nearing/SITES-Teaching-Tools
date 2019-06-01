function jointDensity = create_joint_density(nKernels,kernelType,nMarginals,rho)

% check that we have a coherent number of dimensions
assert(nMarginals >= 2);
assert(round(nMarginals) == nMarginals);

% create marginals:
for m = 1:nMarginals
    jointDensity.marginal{m} = create_mixture_density(nKernels,kernelType);
end

% create copula covariance matrix
if nargin < 4 || nMarginals > 2
    R = randn(nMarginals);
    R = R'*R;
    rho = zeros(nMarginals)./0;
    for r = 1:nMarginals
        rho(r,:) = R(r,:) / sqrt(R(r,r));
    end
    for c = 1:nMarginals
        rho(:,c) = rho(:,c) / sqrt(R(c,c));
    end
else
    rho = [1,rho;rho,1];
end

% store in structure
jointDensity.copulaCovariance = rho;
