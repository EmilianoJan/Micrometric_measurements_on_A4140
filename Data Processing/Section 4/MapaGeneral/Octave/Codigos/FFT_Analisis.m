function [Tabla] = FFT_Analisis(dx, dy, MapaPlano)
%rutina que calcula la FFT de la superficie (por filas y por columnas, y termina promediando todo)

[f,c] = size(MapaPlano);

if f == c 
	if dx == dy
	%calculo por filas
	
		Xdat = MapaPlano(:,1);
		L = f;
		Y = fft(Xdat);
		P2 = abs(Y/L);
		P1 = P2(1:L/2+1);
		P1(2:end-1) = 2*P1(2:end-1);
	
		amp = zeros(length(P1),1);
	
		for x = 1:f
			Xdat = MapaPlano(:,x);
			L = f;
			Y = fft(Xdat);
			P2 = abs(Y/L);
			P1 = P2(1:L/2+1);
			P1(2:end-1) = 2*P1(2:end-1);
			amp = amp + P1;
		end
		
		for x = 1:f
			Xdat = transpose(MapaPlano(x,:));
			L = f;
			Y = fft(Xdat);
			P2 = abs(Y/L);
			P1 = P2(1:L/2+1);
			P1(2:end-1) = 2*P1(2:end-1);
			amp = amp + P1;
		end
		
		amp = amp./(2*f);
		
		Fs = 1/dx;
		frec = transpose( Fs*(0:(L/2))/L);
		Tabla = [frec, amp];
		%plot(f,P1)
	
	else
		error('dx = dy')
	end
else
	error('Tienen que ser matriz de las mismas dimensiones')
end 
 
end