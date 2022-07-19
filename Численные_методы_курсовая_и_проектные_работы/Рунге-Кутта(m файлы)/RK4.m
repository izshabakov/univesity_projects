function [y,t] = RK4(odefun, y0, h_t)
    t(1)=0;
    h = h_t;
    y(1, :) = y0(:)'; 
    i=1;
    while true
        k(1, :) = odefun(t(i), y(i,:));        
        k(2, :) = odefun(t(i) + (h/3), y(i,:) + (h/3)*k(1,:));        
        k(3, :) = odefun(t(i) + (2*h/3), y(i,:) - (h/3)*k(1,:) + h*k(2,:));        
        k(4, :) = odefun(t(i) + h, y(i,:) + h*k(1,:) - h*k(2,:) + h*k(3,:));

        y(i+1, :) = y(i, :) + (h/8)*(k(1,:)+3*k(2,:)+3*k(3,:)+k(4,:));

        if   y(end,2)<0 || y(end,1)<0
            y(end,:)=[];
            break
        else
            i=i+1;
            t(i)=t(i-1) + h;
        end
    end    
end