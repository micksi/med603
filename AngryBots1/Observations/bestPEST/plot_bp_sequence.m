function result = plot_bp_sequence(range, obs)
    % Initialize
    samples = [0 -1; 1 1];
    for i = 1:length(obs)
        [probs, next] = best_pest(range, samples);
        plot(range, probs)
        hold on;
        samples(i+2, :) = [next, obs(i)];
    end
    hold off;
end