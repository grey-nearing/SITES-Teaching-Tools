function sample = sample_mixture_density(mixtureDensity,nSamples)
% Samples a constructed kernel density function

% dimensions:
nKernels = length(mixtureDensity.kernels);

% init storage:
sample = zeros(nSamples,1)./0;

% kernel indexes for each sample:
weightsCDF = cumsum(mixtureDensity.weights);
kernelIndexes = arrayfun(@(x)find(x<weightsCDF,1,'first'),rand(nSamples,1));

% pull appropriate number of samples from each kernel:
edex = 0; % dynamic index for storing in full sample array
for k = 1:nKernels
    
    % number of samples from this kernel:
    nFromKernel = length(find(kernelIndexes==k));
    
    % smaple from kernel:
    switch length(mixtureDensity.params{k})
        case 1
            kernelSample = random(mixtureDensity.kernels{k}, ...
                mixtureDensity.params{k}(1),...
                [nFromKernel,1]);
        case 2
            kernelSample = random(mixtureDensity.kernels{k}, ...
                mixtureDensity.params{k}(1),...
                mixtureDensity.params{k}(2),...
                [nFromKernel,1]);
        case 3
            kernelSample = random(mixtureDensity.kernels{k}, ...
                mixtureDensity.params{k}(1),...
                mixtureDensity.params{k}(2),...
                mixtureDensity.params{k}(3),...
                [nFromKernel,1]);
        case 4
            kernelSample = random(mixtureDensity.kernels{k}, ...
                mixtureDensity.params{k}(1),...
                mixtureDensity.params{k}(2),...
                mixtureDensity.params{k}(3),...
                mixtureDensity.params{k}(4),...
                [nFromKernel,1]);
        otherwise
            error('Unknown number of parameters in kernel #%d (%s): %d \n',...
                k,mixtureDensity.kernels{k},length(mixtureDensity.params{k}));
    end % number of parameters for this kernel
    
    % put kernel sample into full sample vector:
    sdex = edex + 1;
    edex = edex + nFromKernel;
    sample(sdex:edex) = kernelSample;
    
end % k-loop

% randomize sample order:
sample = sample(randperm(nSamples));

% check that all samples were created:
assert(~any(isnan(sample)))
