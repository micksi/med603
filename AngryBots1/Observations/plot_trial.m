function result = plot_trial(fileName)
    data = importtrial(fileName);
    data = data(2:length(data), :); % truncate headers
    scatter(1:length(data), data(:,1), 50, 1 - data(:,2), 'fill')
end