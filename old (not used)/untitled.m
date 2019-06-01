numLoops = 10;
tic;
for loopCounter = 1:numLoops
    fprintf('%d',loopCounter)
end
fprintf(' ... time = %f[s]',toc);
