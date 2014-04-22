function result = logistic(stim, r, t)
    E = 0;
    S = 1;
    B = 2;
    exponent = -r * (t - stim) * 4 * B * S ^ (-1);
    result = E + S * (1 + exp(exponent)) ^ (-1);
end