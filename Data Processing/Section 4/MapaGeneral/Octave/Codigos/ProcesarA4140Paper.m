function [Salida] = ProcesarA4140Paper(A4140a000, tammapa, Paso)

% tammapa = 512;
% Paso = 102;

%genero la tabla
datos = table2array(A4140a000);
[dx,dy, tabla] = GenTabla(datos, tammapa);
xintervalo = [0 dx*tammapa*1e6];

figure
imagescnan(tabla.*1e6,0, xintervalo, xintervalo)
xlabel('Pos Y [um]')
ylabel('Pos X [um]')
a = colorbar;
a.Label.String = 'Altura [um]';

tamBarra = 500;
%Corto los datos en partes de 10um aprox. Los datos son de 50um X 50um.
Salida{1,1} = 0;

for x = 1:10
	interx = ((x-1)*Paso +1):((x)*Paso);
	for y = 1:10
		intery = ((y-1)*Paso +1):((y)*Paso);
		Trecorte = tabla(interx, intery);
		Estadi = CalculoEstadisticosMatriz (dx, dy, Trecorte);
		Salida{x,y} = Estadi;
		PrintSalida(Estadi);
		%PlotSalida(Estadi, tamBarra);
	end 
end

end