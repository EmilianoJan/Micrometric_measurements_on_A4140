function STLSalida3(Resu, FileName)
	aux = Resu.MapaEnderezado;

	[nx, ny] = size(aux);
	X =  zeros(nx,nx);
	Y =  zeros(nx,nx);

	dx = (Resu.TamX(2) -Resu.TamX(1))/nx;
	dy = (Resu.TamY(2) -Resu.TamY(1))/ny;
	for x = 1:(nx)
		for y = 1:(ny)
			X(x,y) = x*dx;
			Y(x,y) = y*dy;
		end
	end
	Xpos = X-(Resu.TamX(2) -Resu.TamX(1))/2;
	Ypos = Y-(Resu.TamY(2) -Resu.TamY(1))/2;
	
	%reescalo todo como para que sea manejable
	Xpos = Xpos * 1e6;
	Ypos = Ypos * 1e6;
	aux = aux * 1e6;
	
	surf2stl(FileName ,Xpos, Ypos, aux,'ascii')

end
