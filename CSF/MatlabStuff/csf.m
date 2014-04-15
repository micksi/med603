% TODO add optional arguments
function result = csf(e, CT0, alpha, e2)
    nom = e2 * log(CT0);
    denom = alpha * (e + e2);
    result = nom / denom;
end