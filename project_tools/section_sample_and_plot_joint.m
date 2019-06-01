function sample = section_sample_and_plot_joint(jointDensity,nSamples,nBins,fignum)

% grab plotting colors
colors = grab_plot_colors;

% Sample the mixture density:
sample = sample_joint_density(jointDensity,nSamples);

% Uncomment to sample directly from a joint gaussian:
% sgX = jointDensity.marginal1.params{1}(2)^2;
% sgY = jointDensity.marginal2.params{1}(2)^2;
% sgXY = jointDensity.param * sgX * sgY;
% R = [sgX,sgXY;sgXY,sgY];
% sample = randn(nSamples,2) * chol(R);

% Discretize the sample:
[histCounts,histEdges] = hist2(sample(:,1:2),nBins);    % this is a custom function
binWidth(1) = histEdges(2,1) - histEdges(1,1);   % bin width in first dimension
binWidth(2) = histEdges(2,2) - histEdges(1,2);   % bin width in second dimension
histProbs = histCounts / nSamples;               % histogram counts -> probability mass
histDensities = histProbs / binWidth(1) / binWidth(2);  % probability mass -> probability density

% Initialize a figure for plotting the sample histogram:
fignum = fignum+1; figure(fignum); close(fignum); figure(fignum);

% Plot sample histogram:
histCenters = zeros(nBins,2)./0;
histCenters(:,1) = histEdges(2:end,1) - 1/2*binWidth(1);
histCenters(:,2) = histEdges(2:end,2) - 1/2*binWidth(2);
sfig = surf(histCenters(:,2),histCenters(:,1),histDensities,'edgecolor','none');
hold on;

% Plot theoretical mixture densities:
[Xtheoretical,Ytheoretical] = plot_mixture_density(jointDensity.marginal{1});
mfig1 = plot3(zeros(size(Xtheoretical))+histCenters(end,2),...
    Xtheoretical,Ytheoretical,...
    'color',colors(4,:),'linewidth',3);

[Xtheoretical,Ytheoretical] = plot_mixture_density(jointDensity.marginal{2});
mfig2 = plot3(Xtheoretical,...
    zeros(size(Xtheoretical))+histCenters(end,1),...
    Ytheoretical,...
    'color',colors(4,:),'linewidth',3);

% Labels:
xlabel('Variable Y')
ylabel('Variable X')
title('First 2 Dimensions of Joint Distribution')
axis([histCenters(1,2),histCenters(end,2),histCenters(1,1),histCenters(end,1)])
% legend([sfig,mfig1],'Sample Histogram','Marginals')

% Plot aesthetics:
set(gca,'fontsize',18);
grid on;
colorbar;

