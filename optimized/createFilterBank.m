function [filterBank] = createFilterBank() 
% Code to generate reasonable filter bank

thetaScales    = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875];
gaussianScales = [1 2 4 8 sqrt(2)*8];
logScales      = [1 2 4 8 sqrt(2)*8];
dxScales       = [1 2 4 8 sqrt(2)*8];
dyScales       = [1 2 4 8 sqrt(2)*8];
lplScales      = [1 2 4 8 sqrt(2)*8];

F = makeLMfilters();

filterBank = cell(numel(thetaScales) + numel(gaussianScales) + numel(logScales) + numel(dxScales) + numel(dyScales) + size(F,3),1);

idx = 0;

for theta = thetaScales
    idx = idx + 1;
    lamb = 3.5;
    gamma=0.3;
    sigma=2.8;
    psii=0;

    sigma_x = sigma;
    sigma_y = sigma/gamma;

    nstds = 5;
    xmax = max(abs(nstds*sigma_x*cos(theta)),abs(nstds*sigma_y*sin(theta)));
    xmax = ceil(max(1,xmax));
    ymax = max(abs(nstds*sigma_x*sin(theta)),abs(nstds*sigma_y*cos(theta)));
    ymax = ceil(max(1,ymax));
    xmin = -xmax; ymin = -ymax;
    [x,y] = meshgrid(xmin:xmax,ymin:ymax);

    x_theta=x*cos(theta)+y*sin(theta);
    y_theta=-x*sin(theta)+y*cos(theta);
    
    filterBank{idx} = exp(-.5*(x_theta.^2/sigma_x^2+y_theta.^2/sigma_y^2)).*cos(2*pi/lamb*x_theta+psii);
end

for scale = gaussianScales
    idx = idx + 1;
    filterBank{idx} = fspecial('gaussian', 2*ceil(scale*2.5)+1, scale);
end

for scale = logScales
    idx = idx + 1;
    filterBank{idx} = fspecial('log', 2*ceil(scale*2.5)+1, scale);
end

for scale = dxScales
    idx = idx + 1;
    f = fspecial('gaussian', 2*ceil(scale*2.5) + 1, scale);
    f = imfilter(f, [-1 0 1], 'same');
    filterBank{idx} = f;
end

for scale = dyScales
    idx = idx + 1;
    f = fspecial('gaussian', 2*ceil(scale*2.5) + 1, scale);
    f = imfilter(f, [-1 0 1]', 'same');
    filterBank{idx} = f;
end

for scale = lplScales
    idx = idx + 1;
    filterBank{idx} = fspecial('laplacian', 2*ceil(scale*2.5)+1, scale);
end

for i=1:size(F,3)
    idx = idx + 1;
    filterBank{idx} = F(:,:,i);
end

return;

