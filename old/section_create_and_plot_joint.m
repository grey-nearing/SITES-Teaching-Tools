function jointDensity = section_create_and_plot_joint...
    (nKernels,kernelType,copulaParameter,fignum)

% grab plotting colors
colors = grab_plot_colors;

% Create joint densities:
jointDensity.marginal1 = create_mixture_density(nKernels,kernelType);
jointDensity.marginal2 = create_mixture_density(nKernels,kernelType);
jointDensity.param = copulaParameter;

% % Uncomment to force an experiment with two standard normals:
% jointDensity.marginal1.kernels = {'Normal'}
% jointDensity.marginal2.kernels = {'Normal'}
% jointDensity.marginal1.weights = 1;
% jointDensity.marginal2.weights = 1;
% jointDensity.marginal1.params{1}(1) = 0;
% jointDensity.marginal1.params{1}(2) = 1;
% jointDensity.marginal2.params{1}(1) = 0;
% jointDensity.marginal2.params{1}(2) = 1;

% Initialize a figure for plotting the mixture density:
fignum = fignum+1; figure(fignum); close(fignum); figure(fignum);
set(gcf,'position',[1,1,1000,350])

% Plot the first mixture:
subplot(1,2,1)
for k = 1:length(jointDensity.marginal1.weights) % plot each kernel
    [Xkernel,Ykernel] = plot_kernel_density(jointDensity.marginal1,k);
    kfig = plot(Xkernel,Ykernel,'color',colors(1,:),'linewidth',1);
    hold on;
end

% Plot theoretical mixture density:
[Xtheoretical,Ytheoretical] = plot_mixture_density(jointDensity.marginal1);
mfig = plot(Xtheoretical,Ytheoretical,'color',colors(4,:),'linewidth',3);

% labels & legend
ylabel('Probability Density: f(X)','fontsize',18);
xlabel('Value of Random Variable: X','fontsize',18);
title('True Marginal (X)','fontsize',24)

% plotting aesthetics
set(gca,'fontsize',18);
grid on;

% Plot the first mixture:
subplot(1,2,2)
for k = 1:length(jointDensity.marginal2.weights) % plot each kernel
    [Xkernel,Ykernel] = plot_kernel_density(jointDensity.marginal2,k);
    kfig = plot(Xkernel,Ykernel,'color',colors(1,:),'linewidth',1);
    hold on;
end

% Plot theoretical mixture density:
[Xtheoretical,Ytheoretical] = plot_mixture_density(jointDensity.marginal2);
mfig = plot(Xtheoretical,Ytheoretical,'color',colors(4,:),'linewidth',3);

% labels & legend
legend([kfig,mfig],'Unweighted Kernels','Mixture Density','location','best');
ylabel('Probability Density: f(Y)','fontsize',18);
xlabel('Value of Random Variable: Y','fontsize',18);
title('True Marginal (Y)','fontsize',24)

% plotting aesthetics
set(gca,'fontsize',18);
grid on;
