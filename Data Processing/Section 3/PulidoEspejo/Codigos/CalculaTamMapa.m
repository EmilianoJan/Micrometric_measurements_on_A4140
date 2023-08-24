function [tammedi] = CalculaTamMapa(datos)

listax = length(unique(round(datos(:,2), 4)));
listay = length(unique(round(datos(:,2), 4)));

if listax == listay
	tammedi = listax;
else
	tammedi = max(listax, listay); %podría indicar que no es un mapa (posiblemente es una línea)
end

end