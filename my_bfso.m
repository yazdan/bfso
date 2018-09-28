% In the name of God

function [pops, pops_cost] = my_bfso(pop_size, p_dim, ...
                                     chem_step, swm_num, ...
                                     rep_step, rep_rate,...
                                     elim_dis_num, elim_dis_prob, ...
                                     flag, bounds, c_type)
    RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock)));
    
    % Number of bacteria in population
    if(nargin < 1) pop_size = 50; end;
    
    % problem Dimension
    if(nargin < 2) p_dim = 2; end;
    
    % Chemomatic Steps
    if(nargin < 3) chem_step = 100; end;
    
    % Swim Number
    if(nargin < 4) swm_num = 4; end;
    
    % Reproduction Step
    if(nargin < 5) rep_step = 4; end;
    
    % Reproduction Number
    if(nargin < 6) rep_rate = 0.5 ; end;
    rep_number = rep_rate * pop_size;
   
    % Elimination and disposal number
    if(nargin < 7) elim_dis_num = 2; end;
    
    % Elimination and disperse probability for a bactri
    if(nargin < 8) elim_dis_prob = 0.25; end;
    
    % If flag=0 indicates that will have nutrients and cell-cell attraction
    % If flag=1 indicates that will have no (zero) nutrients and only cell-cell attraction
    % If flag=2 indicates that will have nutrients and no cell-cell attraction
    if(nargin < 9) flag=2;  end;
    
    
    if(nargin < 10) bounds = [0, 30]; end;
    
    if(nargin < 11) c_type = 1; end;
    
    % Init the population Container
    pops = cell(elim_dis_num, rep_step, chem_step);
    % Init the counters
    chem_cnt = 1;
    rep_cnt = 1;
    elim_cnt = 1;
    
    
    pops{elim_cnt,rep_cnt,chem_cnt} = my_bfso_init(pop_size, p_dim, bounds);
    
    
    % Init the Chemomatic Beahavior    
    chem_bhv = zeros(pop_size,rep_number);
    run_unit=0.1;
    chem_bhv(:,1) = run_unit;
   
    % Inint Cost Container
    pops_cost = cell(elim_dis_num, rep_step);

    
    
   for elim_cnt = 1:elim_dis_num
       for rep_cnt = 1:rep_step
           costs = zeros(chem_step, pop_size);
           for chem_cnt = 1:chem_step
               [n_pop, n_cost, cost] = my_bfso_update(pops{elim_cnt,rep_cnt,chem_cnt}, chem_bhv(:,rep_cnt), swm_num, flag, c_type);
               costs(chem_cnt,:) = cost;
               pops{elim_cnt,rep_cnt,chem_cnt+1} = n_pop;
           end % Chemomatic Step End
           
           pops_cost{elim_cnt, rep_cnt} = costs;
           
           [n_pop, n_chem] = my_bfso_reproduction(pops{elim_cnt,rep_cnt,chem_cnt}, costs, chem_bhv(:,rep_cnt),rep_number);
           
           pops{elim_cnt,rep_cnt + 1,1} = n_pop;
           chem_bhv(:,rep_cnt + 1) =  n_chem;
       end % Reproduction Step End
       
       [n_pop] =  my_bfso_eliminate_disperse(pops{elim_cnt,rep_cnt,chem_cnt}, elim_dis_prob, bounds);
       pops{elim_cnt + 1, 1, 1} = n_pop;
   end % Elimination and Disperse Step End 
   pops = pops(1:end-1, 1:end-1,1:end-1);
end