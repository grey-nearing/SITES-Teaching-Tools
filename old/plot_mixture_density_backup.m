function [PDFpoints,mixtureProbs] = plot_mixture_density(mixtureDensity)
% Plot the theoretical distribution of an arbitrary mixture density 'object'

% dimensions:
nKernels = length(mixtureDensity.kernels);
nSamples = 1e5;

% cdf evaluation points
minPval = 1e-5;
maxPval = 1-minPval;
CDFpoints = [minPval,maxPval];

% init pdf storage
inverseCDF = zeros(nKernels,2)./0;

% get inverse cdf for all kernels at min and max probability cutoffs
for k = 1:nKernels
    switch length(mixtureDensity.params{k})
        case 1
            inverseCDF(k,:) = icdf(mixtureDensity.kernels{k},CDFpoints,...
                mixtureDensity.params{k}(1));
        case 2
            inverseCDF(k,:) = icdf(mixtureDensity.kernels{k},CDFpoints,...
                mixtureDensity.params{k}(1),...
                mixtureDensity.params{k}(2));
        case 3
            inverseCDF(k,:) = icdf(mixtureDensity.kernels{k},CDFpoints,...
                mixtureDensity.params{k}(1),...
                mixtureDensity.params{k}(2),...
                mixtureDensity.params{k}(3));
        case 4
            inverseCDF(k,:) = icdf(mixtureDensity.kernels{k},CDFpoints,...
                mixtureDensity.params{k}(1),...
                mixtureDensity.params{k}(2),...
                mixtureDensity.params{k}(3),...
                mixtureDensity.params{k}(4));
        otherwise
            error('Unknown number of parameters in kernel #%d (%s): %d \n',...
                k,mixtureDensity.kernels{k},length(mixtureDensity.params{k}));
    end % number of parameters for k^th kernel
end % k-loop

% global sampling vector
minGlobal = min(inverseCDF(:));
maxGlobal = max(inverseCDF(:));
PDFpoints = linspace(minGlobal,maxGlobal,nSamples);

% init storage for sample PDF values
kernelProbs = zeros(nKernels,nSamples)./0;

% get inverse cdf for all kernels at min and max probability cutoffs
for k = 1:nKernels
    switch length(mixtureDensity.params{k})
        case 1
            kernelProbs(k,:) = pdf(mixtureDensity.kernels{k},PDFpoints,...
                mixtureDensity.params{k}(1));
        case 2
            kernelProbs(k,:) = pdf(mixtureDensity.kernels{k},PDFpoints,...
                mixtureDensity.params{k}(1),...
                mixtureDensity.params{k}(2));
        case 3
            kernelProbs(k,:) = pdf(mixtureDensity.kernels{k},PDFpoints,...
                mixtureDensity.params{k}(1),...
                mixtureDensity.params{k}(2),...
                mixtureDensity.params{k}(3));
        case 4
            kernelProbs(k,:) = pdf(mixtureDensity.kernels{k},PDFpoints,...
                mixtureDensity.params{k}(1),...
                mixtureDensity.params{k}(2),...
                mixtureDensity.params{k}(3),...
                mixtureDensity.params{k}(4));
        otherwise
            error('Unknown number of parameters in kernel #%d (%s): %d \n',...
                k,mixtureDensity.kernels{k},length(mixtureDensity.params{k}));
    end % number of parameters for k^th kernel
end % k-loop

% weighted sum of sample probabilities
mixtureProbs = sum(kernelProbs .* mixtureDensity.weights);


