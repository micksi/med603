% TODO parameterize
function ecc = eccentricity(cx, cy, x, y, dpi, dist)
    dpc = dpi / 2.54; % dots per centimeter
    adjacent = dist;
    opposite = norm([x - cx, y - cy]) / dpc;
    ecc = radtodeg(atan(opposite / adjacent));
end