function result = plot_interleaved_trial(fileName)
    data = import_interleaved_trial(fileName);
    data = data(2:length(data), :); % truncate headers
    xs = 1:length(data);
    scatter(xs, data(:,2), 25, 1 - data(:,3))
    hold on;
    adata = data((data(:,1) == 1), :);
    axs = xs(data(:, 1) == 1);
    
    ddata = data((data(:,1) == 0), :);
    dxs = xs(data(:, 1) == 0);
    
    plot(axs, adata(:,2), 'r')
    plot(dxs, ddata(:,2), 'g')
    hold off;
end