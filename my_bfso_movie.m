% In the name of God


    function [] = my_bfso_movie(pops, bounds, elim_bnd, rep_bnd, c_type)
    if(nargin<3)
        elim_bnd = [1,1];
    end
    if(nargin<4)
        rep_bnd = [1,1];
    end
    
    % Plot the function we are seeking the minimum of:

    x=bounds(1):(bounds(2)-bounds(1))/200:bounds(2);   % For our function the range of values we are considering
    y=x;

    % Compute the function that we are trying to find the minimum of.

    for jj=1:length(x)
        for ii=1:length(y)
            z(ii,jj)=my_cost_fn([x(jj),y(ii)],flag,c_type);
            %		z(ii,jj)=nutrientsfunc1([x(jj);y(ii)],flag);
        end
    end

    chem_step = size(pops,3);
    rep_step = size(pops,2);
    elim_step = size(pops,1);
    pop_size = size(pops{1,1,1},1);

    figure(2*elim_step+2)
    clf
    contour(x,y,z,25)
    colormap(jet)
    axis([bounds, bounds]);
    xlabel('\theta_1');
    ylabel('\theta_2');
    title('Bacteria movements');
    hold on
    

    M = moviein(chem_step);
     for elim_cnt = elim_bnd(1):elim_bnd(2)
         for rep_cnt = rep_bnd(1):rep_bnd(2)
            for j=1:chem_step-1
                tmp = cell2mat(pops(elim_cnt, rep_cnt,:));
                for i=1:pop_size
                    v = plot(squeeze(tmp(i,1,j:j+1)),squeeze(tmp(i,2,j:j+1)),'-');
                    set(v,'MarkerSize',3);
                end
                M(:,j)=getframe;
            end;
         end;
     end;
end