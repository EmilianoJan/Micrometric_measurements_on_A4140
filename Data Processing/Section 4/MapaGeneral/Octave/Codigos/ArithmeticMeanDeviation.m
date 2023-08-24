function [Ra] = ArithmeticMeanDeviation(Xpos, Zpos)
%Represents the arithmetric mean of the absolute ordinate Z(x) within the sampling length.

Ra = trapz(Xpos, Zpos)/(Xpos(end)- Xpos(1));

end