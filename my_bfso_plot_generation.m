% In the name of God

function [] = my_bfso_plot_generation(pops, bounds, c_type)
    % Plot the function we are seeking the minimum of:

    x=bounds(1):(bounds(2)-bounds(1))/200:bounds(2);   % For our function the range of values we are considering
    y=x;

    % Compute the function that we are trying to find the minimum of.

    for jj=1:length(x)
        for ii=1:length(y)
            z(ii,jj)=my_cost_fn([x(jj),y(ii)],flag, c_type);
        end
    end

    chem_step = size(pops,3);
    rep_step = size(pops,2);
    elim_step = size(pops,1);
    pop_size = size(pops{1,1,1},1);
    
    t=0:chem_step-1;  

    
    for kk=1:elim_step
        for mm=1:rep_step
            sub_idx = mod(mm,4);
            if(sub_idx == 1)
                figure;
            end
            sub_idx(sub_idx == 0) = 4;
            subplot(2,2,sub_idx);
            tmp = cell2mat(pops(kk, mm,:));
            for nn=1:pop_size 
                plot(t,squeeze(tmp(nn,1,:)),t,squeeze(tmp(nn,2,:)))
                axis([min(t) max(t) bounds(1) bounds(2)])
                hold on
            end
            T=num2str(mm);
            T=strcat('Bacteria trajectories, Generation=',T);
            title(T)
            xlabel('Iteration')
            ylabel('\theta_1, \theta_2')
            hold off
        end
    end
    
    for kk=1:elim_step

        for mm=1:rep_step
            sub_idx = mod(mm,4);
            if(sub_idx == 1)
                figure;
            end
            sub_idx(sub_idx == 0) = 4;
            subplot(2,2,sub_idx);
            contour(x,y,z,25)
            colormap(jet)
            tmp = cell2mat(pops(kk, mm,:));
            for nn=1:pop_size  
                hold on
                plot(squeeze(tmp(nn,1,:)),squeeze(tmp(nn,2,:)))
                axis([bounds(1) bounds(2) bounds(1) bounds(2)])
            end
            T=num2str(mm);
            T=strcat('Bacteria trajectories, Generation=',T);
            title(T)
            xlabel('\theta_1');
            ylabel('\theta_2');
            hold off
        end
    end
end
