function y = RK4(odefun, tspan, y0)

    t = tspan(:); 
    h = t(2)-t(1);
    N = length(t);

    y = zeros(N, numel(y0));
    y(1, :) = y0(:)'; 

    k = zeros(4, numel(y0));    

    for i = 1:(N-1)        
        k(1, :) = odefun(t(i), y(i,:));        
        k(2, :) = odefun(t(i) + (h/3), y(i,:) + (h/3)*k(1,:));        
        k(3, :) = odefun(t(i) + (2*h/3), y(i,:) - (h/3)*k(1,:) + h*k(2,:));        
        k(4, :) = odefun(t(i) + h, y(i,:) + h*k(1,:) - h*k(2,:) + h*k(3,:));

        y(i+1, :) = y(i, :) + (h/8)*(k(1,:)+3*k(2,:)+3*k(3,:)+k(4,:));
        
    end    
end