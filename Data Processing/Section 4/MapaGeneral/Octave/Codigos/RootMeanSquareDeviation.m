function [Rq] = RootMeanSquareDeviation(Xpos, Zpos)

Ra = trapz(Xpos, Zpos.^2)/(Xpos(end)- Xpos(1));

Rq= sqrt(Ra);
end
