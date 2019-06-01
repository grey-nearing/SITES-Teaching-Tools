function [kernelNames,nParameters,pBounds] = kernel_list
% This function returns a list of parmaetric kernel densities along with
% the number of parameters required for each and the theoretical bounds on 
% those parameters.

% kernel names
kernelNames{1}  = 'Normal';                     % 2-parameter
kernelNames{2}  = 'Exponential';                % 1-parameter
kernelNames{3}  = 'Uniform';                    % 2-parameter
% kernelNames{4}  = 'Beta';                       % 2-parameter
% kernelNames{5}  = 'Generalized Extreme Value';  % 3-parameter
% kernelNames{6}  = 'Gamma';                      % 2-parameter
% kernelNames{7}  = 'Logistic';                   % 2-parameter
% kernelNames{8}  = 'LogLogistic';                % 2-parameter
% kernelNames{9}  = 'Lognormal';                  % 2-parameter
% kernelNames{10}  = 'Stable';                    % 4-parameter

% number of parameters for each kernel type
nParameters(1)  = 2; % normal
nParameters(2)  = 1; % exponential
nParameters(3)  = 2; % uniform
% nParameters(4)  = 2; % beta
% nParameters(5)  = 3; % generalized extreme value
% nParameters(6)  = 2; % gamma
% nParameters(7)  = 2; % logistic
% nParameters(8)  = 2; % log-logistic
% nParameters(9)  = 2; % lognormal
% nParameters(10) = 4; % stable

% parameter bounds 
pBounds{1}  = [-inf,inf; 0,inf];             % normal
pBounds{2}  = [0,inf];                       % exponential 
pBounds{3}  = [-inf,inf; -inf,inf];          % uniform
% pBounds{4}  = [0.5,10; 0.5,10];              % beta -> [0,inf;0,inf]
% pBounds{5}  = [-inf,inf; 0,inf; -inf,inf];   % generalized extreme value
% pBounds{6}  = [0,inf; 0,inf];                % gamma
% pBounds{7}  = [-inf,inf; 0,inf];             % logistic
% pBounds{8}  = [0,inf; 0,inf];                % log-logistic
% pBounds{9}  = [-inf,inf; 0,inf];             % lognormal
% pBounds{10} = [0,2; -1,1; 0,inf; -inf,inf];  % stable


