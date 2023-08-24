function [puntos, Rdc] = ProfileSectionHeightDifferencePlot(Xpos, Zpos, n)
%Rdc signifies the height difference in section height level c, matching the two material ratios.

minZ = min(Zpos);
maxZ = max(Zpos);
punt = linspace(minZ, maxZ, n);

indi = 1;
sali = 0;
for i = 1:n
	avar = punt(indi);
	sali = [sali; MaterialRatio(Xpos, Zpos, avar)];
	indi = indi +1;
end

puntos = (1:n)./n;
Rdc = sali(2:end);
end