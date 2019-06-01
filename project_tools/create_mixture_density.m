function mixtureDensity = create_mixture_density(nKernels,kernelType)
% Create a mixture density network

% clear all; close all; clc;
% nKernels = 6;
% kernelType = 'Normal';

% Kernel list:
[kernelNames,nParameters,parameterBounds] = kernel_list;

% list of kernels for constructor
if strcmpi(kernelType,'Random') % random kernels
    kernelIndexes = ceil(rand(nKernels,1)*length(kernelNames));
else % choose a single kernel type
    ki = find(strcmpi(kernelType,kernelNames));
    kernelIndexes = repmat(ki,[nKernels,1]);
end

% Random weights for mixture kernels:
kernelWeights = softmax(log(rand(nKernels,1)));

% Random kernel parameters:
parameterValues = cell(nKernels,1);

% handle special case
if strcmpi(kernelType,'Normal') && nKernels == 1
    parameterValues{1}(1) = 0;
    parameterValues{1}(2) = 1;
else
    for k = 1:nKernels % loop through kernels in mixture
        
        % initialize storage for individual kernel's parameters
        parameterValues{k} = zeros(nParameters(kernelIndexes(k)),1)./0;
        
        % loop through parameters in individual kernel
        for p = 1:nParameters(kernelIndexes(k))
            
            % infinite vs. finite range parameters
            if any(isinf(abs(parameterBounds{kernelIndexes(k)}(p,:))))
                pi = -inf;
                while pi <= parameterBounds{kernelIndexes(k)}(p,1) || ...
                        pi >= parameterBounds{kernelIndexes(k)}(p,2)
                    pi = randn(1);
                end
                parameterValues{k}(p) = pi;
            else
                range = parameterBounds{kernelIndexes(k)}(p,2) - ...
                    parameterBounds{kernelIndexes(k)}(p,1);
                pi = rand(1) * range + parameterBounds{kernelIndexes(k)}(p,1);
                parameterValues{k}(p) = pi;
            end
            
        end % p-loop
        
        % catch special cases - uniform
        if strcmpi(kernelNames{kernelIndexes(k)},'uniform')
            pmin = min(parameterValues{k});
            pmax = max(parameterValues{k});
            parameterValues{k}(1) = pmin;
            parameterValues{k}(2) = pmax;
        end
        
    end % k-loop
    
end % special (gaussian) case exception

% Store in structure:
mixtureDensity.kernels = kernelNames(kernelIndexes);
mixtureDensity.params  = parameterValues;
mixtureDensity.weights = kernelWeights;



