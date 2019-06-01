function joint = create_copula_density(nKernels,kernelType,copulaType)

% create two marginal mixture models
marginal1 = create_mixture_density(nKernels,kernelType);
marginal2 = create_mixture_density(nKernels,kernelType);
 
% % turn marginalPDF into CDF
% [PDFpoints1,mixtureProbs] = plot_mixture_density(mixtureDensity1); 
% mixtureCDF1 = cumsum(mixtureProbs);
% 
% [PDFpoints2,mixtureProbs] = plot_mixture_density(mixtureDensity2);
% mixtureCDF2 = cumsum(mixtureProbs);
% 
% create copula
switch copulaType
    case 'Gaussian'
        copula.param = rand(1);
    case 'Ali'
        copula.param = rand(1)*2 - 1;        
    case 'Clayton'
        copula.param = rand(1)*11 - 1;
    case 'Gumbel'
        copula.param = rand(1)*9 + 1;
    otherwise
        error('Unrecognized copula type.')
end

% store in output structrue
joint.marginal{1} = marginal1;
joint.marginal{2} = marginal2;
joint.copula = copula;