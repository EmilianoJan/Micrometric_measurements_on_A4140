function [Rmr] = MaterialRatio (Xpos, Zpos, C)
%Indicates the ratio of the material length Ml(c) of the profile element to the evaluation length for the section height level c (% or μm).
%X,Z muestran el perfil de la muestra
%C Indica el valor de humbral de corte
%Rmr devuelve cuantos intervalos se encuentran por arriba del intervalo. La salida solo puede estan entre [0 1].

indice = 2;
distaSum = 0;
for i = 2:length(Xpos)
	delt = Xpos(indice) - Xpos(indice-1);
	if Zpos(indice)> C
		distaSum = distaSum + delt;
	end
	indice = indice +1;
end
Rmr = distaSum/(Xpos(end) - Xpos(1));

end