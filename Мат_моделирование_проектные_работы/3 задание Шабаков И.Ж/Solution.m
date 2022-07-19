function [y] = Solution(x,t,U,u_t,a,X)
if a>0  
    if x>=a*t
        y=U(x-a*t);
    else
        y=u_t(t-x/a);
    end
else
    if (X-x)>=abs(a)*t
        y=U(X-x-abs(a)*t,X);
    else
        y=u_t(t-(X-x)/abs(a));
    end
end
% function [y] = UForPositive(x,t,u0,mu,a)
%     if(x >= a*t)
%         y = u0(x - a*t);
%     else
%         y = mu(t - x/a);
%     end
% end