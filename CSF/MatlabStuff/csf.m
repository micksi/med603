% TODO add optional arguments
% Important: CT0 is reciprocal, e.g. not 1/64 but just 64
function result = csf(e, CT0, alpha, e2)
    nom = e2 .* log(CT0);
    denom = alpha * (e + e2);
    result = nom ./ denom;
end