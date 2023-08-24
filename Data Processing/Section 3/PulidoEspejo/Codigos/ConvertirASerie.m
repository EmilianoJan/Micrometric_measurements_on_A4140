function [xvec,yvec,valores] = ConvertirASerie(Mapa,  xintervalo, yintervalo)

sali = [0 0 0];

[filas, colu ] = size(Mapa);

pasox = (xintervalo(2)- xintervalo(1))/ filas;
pasoy = (yintervalo(2)- yintervalo(1))/ colu;

for x = 1:filas
	for y = 1:colu
		sali = [sali; xintervalo(1)+pasox*(x-0.5) yintervalo(1)+pasoy*(y-0.5), Mapa(x,y)];
	end
end 
sali = sali(2:end, :);
xvec = sali(:,1);
yvec = sali(:,2);
valores = sali(:,3);

end
