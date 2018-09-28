% In the name of God


function [] = my_bfso_plot_cost(bound, c_type)
    % Plot the function we are seeking the minimum of:

    x=bound(1):(bound(2)-bound(1))/200:bound(2); 
    y=x;

    % Compute the function that we are trying to find the minimum of.

    for jj=1:length(x)
        for ii=1:length(y)
            z(ii,jj)=my_cost_fn([x(jj),y(ii)],flag, c_type);
        end
    end

    % First, show the actual function to be maximized

    figure(1)
    clf
    surf(x,y,z);
    colormap(jet)
    % Use next line for generating plots to put in black and white documents.
%     colormap(white);
    xlabel('x=\theta_1');
    ylabel('y=\theta_2');
    zlabel('z=J');
    title('Nutrient concentration (valleys=food, peaks=noxious)');
end