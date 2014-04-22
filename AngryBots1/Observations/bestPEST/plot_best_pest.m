function plot_best_pest(range, samples)
    for i = 1:size(samples, 1)
       [probs, next] = next_thresh_est(range, samples(1:i, :));
       plot(range, probs);
       hold on;
    end
    hold off;
end