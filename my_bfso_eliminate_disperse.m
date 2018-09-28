% In the name of God


function [n_pop] = my_bfso_eliminate_disperse(pop, elim_dis_prob, bounds, center)
    p_dim = size(pop,2);
    pop_size = size(pop,1);
    if(nargin < 4) center = zeros(1, p_dim); end;
    rnd_val = rand(size(pop,1),1);
    centers = repmat(center, sum(rnd_val < elim_dis_prob), 1);
    n_pop = pop;
    n_pop(rnd_val < elim_dis_prob,:) = centers + (bounds(1) + rand(sum(rnd_val < elim_dis_prob), p_dim) * (bounds(2)- bounds(1)));
end
