% In the name of God


function [n_pop, n_chem_bhv] = my_bfso_reproduction(pop, costs, chem_bhv, rep_number)
    % Calculating the Health
    pop_health = sum(costs,1);
    
    % Sorting due to health
    [pop_health,sortind]=sort(pop_health);
    
    
    n_pop = pop(sortind,:);
    n_chem_bhv = chem_bhv(sortind);
    
    % Spliting the best cells
    n_pop(end - rep_number + (1:rep_number),:) = n_pop((1:rep_number),:);
    n_chem_bhv(end - rep_number + (1:rep_number)) = chem_bhv((1:rep_number));
end