% In the name of God

function [up_pop, up_cost, costs] = my_bfso_update(pop, chem_bhv, swim_num, flag, c_type)
    pop_size = size(pop,1);
    costs = zeros(size(pop,1),1);
    Dric = zeros(size(pop));
    up_pop = zeros(size(pop));
    up_cost = zeros(size(pop,1),1);
    for i = 1:pop_size
        % Nutrition
        costs(i) = my_cost_fn(pop(i,:), flag, c_type);
        % Cell to Cell Attraction
        costs(i) = costs(i) + my_cell2cell_cost_fn(pop, pop(i,:),flag);
        
        %-----------
        % Tumble:
        %-----------
        last_cost = costs(i);
        
        % Generate a random direction
        Dric(i,:)=(2*round(rand(1,size(pop,2)))-1).*rand(1,size(pop,2));
        
        up_pop(i,:) = pop(i,:)+ chem_bhv(i) * Dric(i,:)/sqrt(Dric(i,:)*Dric(i,:)');
        
        up_cost(i) = my_cost_fn(up_pop(i,:),flag,c_type);
        % Cell to Cell Attraction
        up_cost(i) = up_cost(i) + my_cell2cell_cost_fn(up_cost, up_cost(i,:),flag);
        
        swim_cnt = 0;
        
        while swim_cnt < swim_num
            swim_cnt = swim_cnt + 1;
            
            if(up_cost(i) < last_cost)
                last_cost = up_cost(i);
                
                up_pop(i,:) = pop(i,:)+chem_bhv(i) * Dric(i,:)/sqrt(Dric(i,:)*Dric(i,:)');
                
                up_cost(i) = my_cost_fn(up_pop(i,:),flag,c_type);
                % Cell to Cell Attraction
                up_cost(i) = up_cost(i) + my_cell2cell_cost_fn(up_cost, up_cost(i,:),flag);
            else
                swim_cnt = swim_num;
            end
        end % Swim End
    end % Bacterium End
end