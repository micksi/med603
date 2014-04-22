function [probs, next] = next_thresh_est(range, samples)
    if(size(samples, 2) < 1)
        probs = prob_response(range, 1, median(range));
        next = median(range);
    else
        probs = zeros(length(range), 1);
        for i = 1:length(range)
            x = range(i);
            prob = 0;
            for j = 1:size(samples, 1)
                prob = prob + log(prob_response(x, samples(j,2), samples(j,1)));
            end;
            probs(i) = prob;
        end
        next = 0
end