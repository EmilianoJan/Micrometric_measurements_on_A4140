function [Sq] = RootMeanSquare_Superficie(dx, dy, ZMapa)

[mx, my] = size(ZMapa);

S = mx*dx*my*dy;

mapa = ZMapa - min(min(ZMapa));
mapa = mapa.*1e9;
mapa = mapa.^2;

suma = 0;

for x = 1:mx
	for y = 1:my
		suma = suma + mapa(x,y)*dx*dy;
	end
end

Sq = sqrt(suma/S);

end


