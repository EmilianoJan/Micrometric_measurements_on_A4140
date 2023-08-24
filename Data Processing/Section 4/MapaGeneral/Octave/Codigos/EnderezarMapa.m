function [MapaS] = EnderezarMapa(Mapa)
%la rutina se encaraga de empleando la información de los extremos del mapa
%sacar la información de la corrección del mapa. Permite corregir en forma lineal
%las inclinaciones de la muestra


[mx, my] = size(Mapa);

a = Mapa(1,1);
b = Mapa(mx,1);
c = Mapa(1,my);
%d = Mapa(mx,my);

gamma = a;
alfa = (b- gamma)/mx;
beta = (c- gamma)/my;
MapaS = zeros(mx,my);

for x = 1:mx
	for y = 1:my
		MapaS(x,y) = Mapa(x,y) - (alfa*x + beta*y+ gamma);
	end
end

end