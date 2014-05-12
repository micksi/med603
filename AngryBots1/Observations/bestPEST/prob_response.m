function result = prob_response(phi, r, theta, E, S, B)
    exponent = -r * (theta - phi) * 4 * B * S .^ (-1);
    result = E + S * ((1 + exp(exponent)) .^ (-1));
end