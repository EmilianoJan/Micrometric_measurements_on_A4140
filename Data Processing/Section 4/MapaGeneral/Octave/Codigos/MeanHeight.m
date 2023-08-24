function [Rc] = MeanHeight (Zpos)
%Represents the mean for the height Zt of profile elements within the sampling length.

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
				sele = Zpos(pini:indice);
				pap = max(sele)-min(sele);
				alturas = [alturas; pap];
			end
			paso = 1;
			pini = indice;
		end 
	end	
	indice = indice +1;
end

alturas = alturas(2:end);
Rc = mean(alturas);

end