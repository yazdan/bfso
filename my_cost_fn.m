% In the name of God

function [cost] = my_cost_fn(X, flag, c_type)
    if(nargin < 2) flag = 0; end;
    if(nargin < 3) c_type = 1; end;
    
    if (flag==1)
        cost=0;
        return
    end
    
    
    if(c_type == 1)
        theta = X';
        cost=...
            +5*exp(-0.1*((theta(1,1)-15)^2+(theta(2,1)-20)^2))...
            -2*exp(-0.08*((theta(1,1)-20)^2+(theta(2,1)-15)^2))...
            +3*exp(-0.08*((theta(1,1)-25)^2+(theta(2,1)-10)^2))...
            +2*exp(-0.1*((theta(1,1)-10)^2+(theta(2,1)-10)^2))...
            -2*exp(-0.5*((theta(1,1)-5)^2+(theta(2,1)-10)^2))...
            -4*exp(-0.1*((theta(1,1)-15)^2+(theta(2,1)-5)^2))...
            -2*exp(-0.5*((theta(1,1)-8)^2+(theta(2,1)-25)^2))...
            -2*exp(-0.5*((theta(1,1)-21)^2+(theta(2,1)-25)^2))...
            +2*exp(-0.5*((theta(1,1)-25)^2+(theta(2,1)-16)^2))...
            +2*exp(-0.5*((theta(1,1)-5)^2+(theta(2,1)-14)^2));
    elseif(c_type == 2)
        cost = sum(X.^2);
    elseif(c_type == 3)
        cost = sum((1:length(X)).*X.^2);
    elseif(c_type == 4)
        cost = sum(X.^2 - 10 * cos(2 * pi * X));
    elseif(c_type == 5)
        cost = sum(-X .* sin(sqrt(abs(X))));
    elseif(c_type == 6)
        a = 20;
        b = 0.2;
        c = 2 * pi;
        n = length(X);
        cost = -a*exp(-b*sqrt(1/n*sum(X.^2)))-exp(1/n*sum(cos(c*X)))+a+exp(1);
    end
end