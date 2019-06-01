function [Ixy,Hx,Hy] = kernel_info(X,Y,h)

% dimensions
Nx = size(X,1);
Ny = size(Y,1);
assert(Nx == Ny); 

% kernel estimates
if h < 0
    [fxy,~,h] = ksdensity([X,Y],[X,Y]);
else
    h = [h,h];
    fxy = ksdensity([X,Y],[X,Y],'Bandwidth',h);
end
fx = ksdensity(X,X,'Bandwidth',h(1));
fy = ksdensity(Y,Y,'Bandwidth',h(2));

% information metrics
Ixy = mean(log(fxy./fx./fy));
Hx = -mean(log(fx));
Hy = -mean(log(fy));
