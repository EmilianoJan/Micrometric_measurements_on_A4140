function [Rdq] = RootMeanSquareSlope (Xpos, Zpos)
% Represents the root mean square for the local slope dz/dx within the sampling length.
% Pdq  The root mean square slope for the primary profile
% Wdq  The root mean square slope for the waviness

[XSali, Yprima] = DerivadaDiscreta(Xpos, Zpos);
 
Rdq =  RootMeanSquareDeviation(XSali, Yprima);

end