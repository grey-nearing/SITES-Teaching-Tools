% fx = Px * binWidth(1);
% fy = Py * binWidth(2);
% fxy = Pxy * binWidth(1) * binWidth(2);

% for x = 1:nBins
%     Py_x(x,:) = Pxy(x,:) / sum(Pxy(x,:));
% end
% 
% Pyy = repmat(Py',[nBins,1]);
% Ixy1 = sum(Pxy(Pxy>0) .* log(Py_x(Pxy>0)./Pyy(Pxy>0)));
