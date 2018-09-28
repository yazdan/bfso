% In the name of God


function [pop] = my_bfso_init(pop_size, p_dim, bounds, center)
    if(nargin < 4) center = mean(bounds)*ones(1, p_dim); end;
    centers = repmat(center, pop_size, 1);
%     pop = centers + (bounds(1) + rand(pop_size, p_dim) * (bounds(2)- bounds(1)));
    pop = centers + ((bounds(2) - bounds(1))/2)*((2*round(rand(pop_size, p_dim))-1).*rand(pop_size, p_dim));
end