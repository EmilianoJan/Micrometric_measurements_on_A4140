function [RSm] = MeanWidth (Xpos, Zpos)
% Represents the mean for the length Xs of profile elements within the sampling length.
%     Indicated as Sm within JIS’94
%     Minimum height and minimum length to be discriminated from peaks (valleys) 
% Minimum height discrimination: 10% of the Rz value
% Minimum length discrimination: 1% of the reference length

media = mean(Zpos);

pini = 1;
indice = 2;
paso = 0;
alturas = 0;
for i = 2:length(Zpos)
	if Zpos(indice) > media 
		if Zpos(indice -1) < media
			if paso == 1
				%tengo todo el intervalo ya calculado
				dis = Xpos(indice) - Xpos(pini);
				alturas = [alturas; dis];
			end
			paso = 1;
			pini = indice;
		end 
	end	
	indice = indice +1;
end

alturas = alturas(2:end);
RSm = mean(alturas);
end