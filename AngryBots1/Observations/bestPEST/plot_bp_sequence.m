function samples = plot_bp_sequence(range, sequence)
    % Initialize
    samples = [0 -1; 1 1];
    [probs, next] = next_thresh_est(range, samples);
    plot(range, probs)
    hold on;
    scatter(next, max(probs));
    for i = 1:length(sequence)
        samples(i+2, :) = [next, sequence(i)];
        [probs, next] = next_thresh_est(range, samples);
        plot(range, probs)
        scatter(next, max(probs));
    end
    
    hold off;
end