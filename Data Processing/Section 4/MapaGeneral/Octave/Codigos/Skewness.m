function [Rsk] = Skewness(Xpos, Zpos)
% The quotient of the mean cube value of Z (x) and the cube of R8 within a sampling length.
% Rsk=0: Symmetric against the mean line (normal distribution)
% Rsk>0: Deviation beneath the mean line
% Rsk<0: Deviation above the mean line

Ra = trapz(Xpos, Zpos.^3)/(Xpos(end)- Xpos(1));

Rsk = Ra/(RootMeanSquareDeviation(Xpos, Zpos)).^3;
end
