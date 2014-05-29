% TODO parameterize
function result = screen_eccentricities(xres, yres, dpi, dist)
    switch nargin
        case 2
            dpi = 100.45;
            dist = 70; % cm
        case 3
            dist = 70; % cm
    end
    
    Z = zeros(yres,xres);
    
    for y = 1:size(Z,1)
        for x = 1:size(Z,2)
            Z(y,x) = eccentricity(xres/2,yres/2, x, y, dpi, dist);
        end
    end
    result = Z;
    % use mesh(result) to plot 
end