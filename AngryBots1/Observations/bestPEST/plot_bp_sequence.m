function samples = plot_bp_sequence(Range, sequence, B)
    % Initialize
    samples = [min(Range) -1;max(Range) 1];
    [probs, next] = next_thresh_est(Range, samples, B);
    plot(Range, probs)
    hold on;
    scatter(next, max(probs));
    for i = 1:length(sequence)
        samples(i+2, :) = [next, sequence(i)];
        [probs, next] = next_thresh_est(Range, samples, B);
        plot(Range, probs)
        scatter(next, max(probs));
    end
    
    hold off;
end