function [PDFpoints,kernelProbs] = plot_kernel_density(mixtureDensity,k)
% Plot the theoretical distribution of a single kernel of an arbitrary 
% mixture density 'object'

% error checking
assert(k <= nKernels);

% dimensions:
nKernels = length(mixtureDensity.kernels); 
nSamples = 1e3;

% cdf evaluation points
minPval = 1e-5;
maxPval = 1-minPval;
CDFlims = [minPval,maxPval];

% get inverse cdf for active kernel at sample points
switch length(mixtureDensity.params{k})
    case 1
        inverseCDFlims = icdf(mixtureDensity.kernels{k},CDFlims,...
            mixtureDensity.params{k}(1));
    case 2
        inverseCDFlims = icdf(mixtureDensity.kernels{k},CDFlims,...
            mixtureDensity.params{k}(1),...
            mixtureDensity.params{k}(2));
    case 3
        inverseCDFlims = icdf(mixtureDensity.kernels{k},CDFlims,...
            mixtureDensity.params{k}(1),...
            mixtureDensity.params{k}(2),...
            mixtureDensity.params{k}(3));
    case 4
        inverseCDFlims = icdf(mixtureDensity.kernels{k},CDFlims,...
            mixtureDensity.params{k}(1),...
            mixtureDensity.params{k}(2),...
            mixtureDensity.params{k}(3),...
            mixtureDensity.params{k}(4));
    otherwise
        error('Unknown number of parameters in kernel #%d (%s): %d \n',...
            k,mixtureDensity.kernels{k},length(mixtureDensity.params{k}));
end % number of parameters for k^th kernel

% pdf sampling vector
CDFpoints = linspace(inverseCDFlims(1),inverseCDFlims(2),nSamples);

% get densities for active kernel at sample points
switch length(mixtureDensity.params{k})
    case 1
        kernelDensity = cdf(mixtureDensity.kernels{k},CDFpoints,...
            mixtureDensity.params{k}(1));
    case 2
        kernelDensity = cdf(mixtureDensity.kernels{k},CDFpoints,...
            mixtureDensity.params{k}(1),...
            mixtureDensity.params{k}(2));
    case 3
        kernelDensity = cdf(mixtureDensity.kernels{k},CDFpoints,...
            mixtureDensity.params{k}(1),...
            mixtureDensity.params{k}(2),...
            mixtureDensity.params{k}(3));
    case 4
        kernelDensity = cdf(mixtureDensity.kernels{k},CDFpoints,...
            mixtureDensity.params{k}(1),...
            mixtureDensity.params{k}(2),...
            mixtureDensity.params{k}(3),...
            mixtureDensity.params{k}(4));
    otherwise
        error('Unknown number of parameters in kernel #%d (%s): %d \n',...
            k,mixtureDensity.kernels{k},length(mixtureDensity.params{k}));
end % number of parameters for k^th kernel

% densities -> probabilities by integrating over range
kernelProbs = diff(kernelDensity) / diff(CDFpoints(1:2));

% center points of sampling
PDFpoints = CDFpoints(2:end) - 0.5 * diff(CDFpoints(1:2));
