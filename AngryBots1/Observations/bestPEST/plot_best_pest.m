function plot_best_pest(range, samples)
    for i = 1:length(samples)
       [probs, next] = best_pest(range, samples(1:i, :));
       plot(range, probs);
       hold on;
    end
    hold off;
end