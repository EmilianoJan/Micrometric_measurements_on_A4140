function [Rku] = Kurtosis(Xpos, Zpos)
% The quotient of the mean quadratic value of Z (x) and the fourth power of Rq within a sampling length.
% Rku=3: Normal distribution
% Rku>3: The height distribution is sharp
% Rku<3: The height distribution is even

Ra = trapz(Xpos, Zpos.^4)/(Xpos(end)- Xpos(1));

Rku = Ra/(RootMeanSquareDeviation(Xpos, Zpos)).^4;
end
