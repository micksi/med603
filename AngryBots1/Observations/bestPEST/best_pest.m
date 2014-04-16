function [probs, s] = best_pest(range, samples)
    probs = zeros(length(range), 1);
    for j = 1:length(range)
       x = range(j);
       prob = 0;
       for i = 1:size(samples, 1)
           prob = prob + log(logistic(x, samples(i,2), samples(i,1)));
       end
       probs(j) = prob;
    end
    [C, I] = max(probs);
    s = range(I);
    
end

function result = logistic(stim, r, t)
    E = 0;
    S = 1;
    B = 2;
    result = (1 + exp(r * (t - stim) * 4 * B * S ^ (-1))) ^(-1);
end