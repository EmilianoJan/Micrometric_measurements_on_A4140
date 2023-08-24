function [X, Y, Z] = Gen3DPlot (mapaTiltX, mapaTiltY, xintervalo, yintervalo)
%Rutina que se encarga de generar una figura 3d con la información de las inclinaciones 
%de la muestra.
%mapaTiltX matriz con los datos en ángulos
%mapaTiltY matriz con los datos en ángulos
%xintervalo Intervalo de valores dado en micrones
%xintervalo Intervalo de valores dado en micrones

	%valores que desconozco, valor que vuelvo nulo
	mapaTiltX(isnan(mapaTiltX)) = 0;
	mapaTiltY(isnan(mapaTiltY)) = 0;

	Xtilt = mapaTiltX - mean(mean(mapaTiltX));
	Ytilt = mapaTiltY - mean(mean(mapaTiltY));
	%Ytilt = -Ytilt;
	%Xtilt = -Xtilt;
	Rx = tan(Xtilt.*pi/180);
	Ry = tan(Ytilt.*pi/180);
	[colx, filx ] = size(Rx);
	Rzy = zeros(filx +1, colx+1);
	Rzx = zeros(filx +1, colx+1);

	[nx, ny] = size(Xtilt);
	X =  zeros(nx+1,nx+1);
	Y =  zeros(nx+1,nx+1);

	dx = (xintervalo(2) -xintervalo(1))/nx;
	dy = (yintervalo(2) -yintervalo(1))/ny;
	for x = 1:(nx+1)
		for y = 1:(ny +1)
			X(x,y) = x*dx;
			Y(x,y) = y*dy;
		end
	end
	X = X-(xintervalo(2) -xintervalo(1))/2;
	Y = Y-(yintervalo(2) -yintervalo(1))/2;


	for x = 1:colx
		Rzx(x+1, 1:end-1) = Rzx(x, 1:end-1)  + Ry(x,:)*dx;
	end

	for y = 1:colx
		Rzy(1:end-1, y+1) = Rzy(1:end-1, y)  + Rx(:,y)*dx;
	end

	Rz = Rzx + Rzy;
	Rz = Rz(1:end-1, 1:end-1);
	X = X(1:end-1, 1:end-1);
	Y = Y(1:end-1, 1:end-1);
	Rz = Rz *-1;
	Rz = Rz - min(min(Rz));
	figure
	surf(X,Y,Rz,'LineStyle','none','FaceColor','interp')
	%surf(X,Y,Rz)
	xlabel('Posición X [\mum]')
	ylabel('Posición Y [\mum]')
	%zlabel('Altura [\mum]')
	a = colorbar;
	a.Label.String = 'Altura [\mum]';
	axis equal
	%axis 'auto z'
	Z = Rz;
end