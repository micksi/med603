function result = plot_csf(ecc, CT0, alpha, e2)
    switch nargin
        case 1
            CT0 = 64;
            alpha = 0.106;
            e2 = 2.3;
        case 2
            alpha = 0.106;
            e2 = 2.3;
        case 1
            e2 = 2.3;
    end
    result = zeros(size(ecc));
    for x = 1:size(ecc,1)
        for y = 1:size(ecc,2)
            result(x,y) = csf(ecc(x,y), CT0, alpha, e2);
        end
    end
    % use mesh(result) to plot 
end