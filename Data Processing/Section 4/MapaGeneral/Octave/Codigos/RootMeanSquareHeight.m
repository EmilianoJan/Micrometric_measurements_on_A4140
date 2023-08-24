function [Sq] = RootMeanSquareHeight (dx, dy, ZTabla)
%Sq represents the root mean square value of ordinate values within the 
%definition area. It is equivalent to the standard deviation of heights.

ZTabla = ZTabla - mean(mean(ZTabla));

modulo = ZTabla.^2.*dx.*dy;

[tax, tay] = size(ZTabla);

area =  tax*dx*tay*dy;
Sq = sqrt( sum(sum(modulo))./area);



end