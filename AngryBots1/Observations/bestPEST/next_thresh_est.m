function [probs, next] = next_thresh_est(Range, samples, B)
    if(size(samples, 1) < 1)
        probs = prob_response(Range, -1, median(Range));
        next = median(Range);
    else
        E = min(Range);
        S = range(Range);
        probs = zeros(length(Range), 1);
        for i = 1:length(Range)
            x = Range(i);
            prob = 0;
            for j = 1:size(samples, 1)
                prob = prob + log(prob_response(x, samples(j,2), samples(j,1), E, S, B));
            end;
            probs(i) = prob;
        end
        [m, I] = max(probs);
        next = Range(I);
end