function     [PDFpoints,PDFprobs] = plot_kernel_density(mixtureDensity,k)
% Plot the theoretical distribution of a single kernel of an arbitrary 
% mixture density 'object'

% dimensions:
nKernels = length(mixtureDensity.kernels); 
nSamples = 1e2;

% error checking
assert(k <= nKernels);

% cdf evaluation points
CDFprobs = linspace(0,1,nSamples);
CDFprobs(1) = []; CDFprobs(end) = [];

% get inverse cdf for active kernel at sample points
switch length(mixtureDensity.params{k})
    case 1
        CDFpoints = icdf(mixtureDensity.kernels{k},CDFprobs,...
            mixtureDensity.params{k}(1));
    case 2
        CDFpoints = icdf(mixtureDensity.kernels{k},CDFprobs,...
            mixtureDensity.params{k}(1),...
            mixtureDensity.params{k}(2));
    case 3
        CDFpoints = icdf(mixtureDensity.kernels{k},CDFprobs,...
            mixtureDensity.params{k}(1),...
            mixtureDensity.params{k}(2),...
            mixtureDensity.params{k}(3));
    case 4
        CDFpoints = icdf(mixtureDensity.kernels{k},CDFprobs,...
            mixtureDensity.params{k}(1),...
            mixtureDensity.params{k}(2),...
            mixtureDensity.params{k}(3),...
            mixtureDensity.params{k}(4));
    otherwise
        error('Unknown number of parameters in kernel #%d (%s): %d \n',...
            k,mixtureDensity.kernels{k},length(mixtureDensity.params{k}));
end % number of parameters for k^th kernel

% densities -> probabilities by integrating over range
PDFprobs = diff(CDFprobs(1:2)) ./ diff(CDFpoints);

% center points of sampling
PDFpoints = CDFpoints(2:end) - 0.5 * diff(CDFpoints(1:2));
