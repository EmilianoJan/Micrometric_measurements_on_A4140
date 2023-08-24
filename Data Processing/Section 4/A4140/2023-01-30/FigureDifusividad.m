%close all;
clear all;

%Script que se encarga de unir los datos 

load('2023-01-30_Med_0.mat');

tammapa = 15;
tammapaP = tammapa ;
rangoMapa = 0.201;
rangoMapaPosta = 0.2;

hacerPlots = 1;


mapaRein = zeros(tammapaP,tammapaP);
mapaTiltX = zeros(tammapaP,tammapaP);
mapaTiltY = zeros(tammapaP,tammapaP);
mapaBuenaMed = zeros(tammapaP,tammapaP);
mapaReinBuena = zeros(tammapaP,tammapaP);
mDifuA = zeros(tammapaP,tammapaP);
mDifuB = zeros(tammapaP,tammapaP);
mDifuC = zeros(tammapaP,tammapaP);
mFocus = zeros(tammapaP,tammapaP);
mErroAju = zeros(tammapaP,tammapaP);
%mTilT = zeros(tammapaP,tammapaP);

indiceAux = floor(tammapa/2) +1 ;

% PosX = round(round(datos(:,2), 6)./(rangoMapa/tammapa)) + indiceAux;
% PosY = round(round(datos(:,3), 6)./(rangoMapa/tammapa)) + indiceAux;

PosX = round((datos(:,2)+ rangoMapa/2 )  ./(rangoMapa/(tammapa-1))) + 1;
PosY = round((datos(:,3)+ rangoMapa/2 )  ./(rangoMapa/(tammapa-1))) + 1;

%calculado con calibración interna
% yintervalo = [-1500*rangoMapaPosta/2, 1500*rangoMapaPosta/2];
% xintervalo = [-1500*rangoMapaPosta/2, 1500*rangoMapaPosta/2];

%calculado con referencia a fotografía caracterizada
yintervalo = [-96.13; 96.13];
xintervalo = [-96.13; 96.13];

xintervalo = xintervalo - xintervalo(1);
yintervalo = yintervalo - yintervalo(1);


% PosX(PosX == 0) = 1;
% PosY(PosY == 0) = 1;

% PosX(PosX == 16) = 15;
% PosY(PosY == 16) = 15;

% PosX(PosX(:) >= indiceAux) = PosX(PosX(:) >= indiceAux)-1;
% PosY(PosY(:) >= indiceAux) = PosY(PosY(:) >= indiceAux)-1;


for e = 1:225
	x = PosX(e);
	y = PosY(e);
	mapaRein(x,y) = datos(e,11);
	mapaBuenaMed(x,y) = datos(e,4);
	%filtro por buenas mediciones
	if (datos(e,4) == 1)
		
		mapaTiltX(x,y) = datos(e,60); %9
		mapaTiltY(x,y) = datos(e,66); %10
		mapaReinBuena(x,y) = datos(e,11);
		mFocus(x,y) = datos(e,74);
		if(datos(e,112) < 0.1)
			if (datos(e,108) < 0.15)
				mDifuA(x,y) = datos(e,108);
				mErroAju(x,y) = datos(e,112);
			end 
		end
		if(datos(e,129) < 0.1)
			if (datos(e,125) < 0.15)
				mDifuB(x,y) = datos(e,125);
			end 
		end
		if(datos(e,146) < 0.1)
			if (datos(e,142) < 0.15)
				mDifuC(x,y) = datos(e,142);
			end 
		end
		
	end
end

mapaRein(mapaRein(:,:) == 0) = NaN;
mapaReinBuena(mapaReinBuena(:,:) == 0) = NaN;
mapaTiltX(mapaTiltX(:,:) == 0) = NaN;
mapaTiltY(mapaTiltY(:,:) == 0) = NaN;
mDifuA(mDifuA(:,:) == 0) = NaN;
mDifuB(mDifuB(:,:) == 0) = NaN;
mDifuC(mDifuC(:,:) == 0) = NaN;
mFocus(mFocus(:,:) == 0) = NaN;
mFocus = mFocus.*6.56e-3*100*1e3;
mFocus(mFocus(:,:) < -200) = NaN;
mErroAju(mErroAju(:,:) == 0) = NaN;

% mapaRein = TransformarAImagen(mapaRein);
% mapaReinBuena = TransformarAImagen(mapaReinBuena);
% mapaTiltX = TransformarAImagen(mapaTiltX);
% mapaTiltY = TransformarAImagen(mapaTiltY);
% mDifuA = TransformarAImagen(mDifuA);
% mDifuB = TransformarAImagen(mDifuB);
% mDifuC = TransformarAImagen(mDifuC);
% mFocus = TransformarAImagen(mFocus);
% mErroAju = TransformarAImagen(mErroAju);


%calculo el mapa promediado de difusividad térmica.
mProme = zeros(tammapaP,tammapaP);

for x = 1:tammapaP
	for y = 1:tammapaP
		cuenta = 0;
		avar = 0;
		if isnan(mDifuA(x,y)) == 0
			avar = avar  + mDifuA(x,y);
			cuenta = cuenta +1;
		end
		
		if isnan(mDifuB(x,y)) == 0
			avar = avar  + mDifuB(x,y);
			cuenta = cuenta +1;
		end
		
		if isnan(mDifuC(x,y)) == 0
			avar = avar  + mDifuC(x,y);
			cuenta = cuenta +1;
		end
		
		if cuenta == 0 
			mProme(x,y) = NaN;
		else
			mProme(x,y) = avar/cuenta;
		end
	end
end

figure
imagescnan(TransformarAImagen(mProme),0, xintervalo, yintervalo)
ylabel('Y position [\mum]')
xlabel('X position [\mum]')

a = colorbar;
a.Label.String = 'Thermal diffusivity [cm^2/s]';

xintervalo = (xintervalo - xintervalo(1)).*1e-6;
yintervalo = (yintervalo - yintervalo(1)).*1e-6;

TamHaz = 2.2e-6*1.5;
serieColor = 0;
NombreCampo = 'Thermal diffusivity [cm^2/s]';
CantPixels = 917;
tamPixel = (96.13e-6*2)/CantPixels;
DireccionImagen = 'MapaAltaRes2.png';
AlphaVal = 0.75;

if (hacerPlots == 1)
	figure
	ImagenSuperpuesta (DireccionImagen, mProme, xintervalo, yintervalo, TamHaz, AlphaVal, serieColor, tamPixel,  NombreCampo)

	AlphaVal = 0.5;
	NombreCampo = 'X Angle [º]';
	figure
	ImagenSuperpuesta (DireccionImagen, mapaTiltX, xintervalo, yintervalo, TamHaz, AlphaVal, serieColor, tamPixel,  NombreCampo)

	NombreCampo = 'X Angle [º]';
	figure
	ImagenSuperpuesta (DireccionImagen, mapaTiltY, xintervalo, yintervalo, TamHaz, AlphaVal, serieColor, tamPixel,  NombreCampo)


% 	MapaFilas = ones(15,1)*(1:15);
% 	MapaColumnas = transpose(MapaFilas);
% 
% 	NombreCampo = 'Filas';
% 	figure
% 	ImagenSuperpuesta (DireccionImagen, MapaFilas, xintervalo, yintervalo, TamHaz, AlphaVal, serieColor, tamPixel,  NombreCampo)
% 
% 	NombreCampo = 'Columnas';
% 	figure
% 	ImagenSuperpuesta (DireccionImagen, MapaColumnas, xintervalo, yintervalo, TamHaz, AlphaVal, serieColor, tamPixel,  NombreCampo)

end

mPromeb = mProme;
reshape(mPromeb,1,[]); 
mPromeb = mPromeb(~isnan(mPromeb));

mDif = mean(mPromeb);
stdDif = std(mPromeb);
Disper = (stdDif/mDif)*100;

figure 
histogram(mPromeb, 15)
title (['D_{mean} = ' , num2str(round(mDif, 3)) , '+/-', num2str(round(stdDif, 3)) , '[cm^2/s]  Disp. = ' , num2str(round(Disper, 0)) , '%' ]);
grid on
grid minor
xlabel('Thermal diffusivity [cm^2/s]')

% posx = [1; -20; 30];
% posy = [1; 20; 120];
% valores = [1;4;10];
% TamHaz = 0.00003;
% 
% figure
% ImagenSuperpuesta (DireccionImagen, posx, posy,valores , TamHaz, AlphaVal, serieColor, tamPixel,  NombreCampo)




%realizo un estudio por regiones, analizando el valor medio de las mismas.

AltasFilas = [15 15 15 14 14 14 14 14 13 13 13 12 12 12 11 11 11 11 10 10 10 9 9 8 7 7];
AltasColumnas = [14 10 9 15 13 12 11 10 14 13 12 14 13 11 15 14 12 11 15 14 13 13 12 14 15 14];

BajasFilas = [4 4 4 4 4 4 4 5 5 5 5 5 5 6 6 6 6 7 7 7 7 8 8 8 8 8 8 9 9 9 9 9 9 10 10 10 10];
BajasColumnas = [13 12 11 10 9 7 6 13 11 10 9 7 6 12 11 10 9 11 10 7 6 11 10 9 8 7 6 10 9 8 7 6 5 9 8 7 6];

BajasFilaB = [5 5 6 6 6 7 7 8 8 8 9 9 9 10 10];
BajsColumnasB = [13 11 12 11 10 11 10 10 9 8 10 9 8 9 8];


%mediciones altas
Altasindice = transpose([AltasColumnas; AltasFilas]);
SelAltas = 0;
i = 0;
for i = 1:length(Altasindice(:,1))
	SelAltas = [SelAltas; mProme(Altasindice(i,1), Altasindice(i,2))];
end
SelAltas = SelAltas(2:end);
MediaAltas = mean(SelAltas);
DesvioAltas = std(SelAltas);


%medición zona baja 1
Bajasindice = transpose([BajasColumnas; BajasFilas]);
SelBajas = 0;
i = 0;
for i = 1:length(Bajasindice(:,1))
	SelBajas = [SelBajas; mProme(Bajasindice(i,1), Bajasindice(i,2))];
end
SelBajas = SelBajas(2:end);
MediaBajas = mean(SelBajas);
DesvioBajas = std(SelBajas);


%medición zona baja 2
BajasBindice = transpose([BajsColumnasB; BajasFilaB]);
SelBajasB = 0;
i = 0;
for i = 1:length(BajasBindice(:,1))
	SelBajasB = [SelBajasB; mProme(BajasBindice(i,1), BajasBindice(i,2))];
end
SelBajasB = SelBajasB(2:end);
MediaBajasB = mean(SelBajasB);
DesvioBajasB = std(SelBajasB);

disp(['Zona alta:' num2str(MediaAltas) '[cm^2/s]   Mínimo con desvío: ' num2str(MediaAltas - DesvioAltas)])

disp(['Zona baja:' num2str(MediaBajas) '[cm^2/s]   Máximo con desvío: ' num2str(MediaBajas + DesvioBajas)])

disp(['Zona baja:' num2str(MediaBajasB) '[cm^2/s]   Máximo con desvío: ' num2str(MediaBajasB + DesvioBajasB)])


figure
histogram(SelAltas, 10)
hold on
histogram(SelBajasB, 10)
xlabel('Thermal diffusivity [cm^2/s]')
ylabel ('Counts')
grid on
grid minor
legend('Upper zone', 'Lower zone')


%reconstruyo el mapa mostrando las ubicaciones de las dos zonas con el valor medio

if (hacerPlots == 1)
	
	DatoSele = mProme;
	DatoSele = DatoSele.*nan;
	i = 0;
	for i = 1:length(Altasindice(:,1))
		DatoSele(Altasindice(i,1), Altasindice(i,2)) = MediaAltas;
	end
	
	i = 0;
	for i = 1:length(BajasBindice(:,1))
		DatoSele(BajasBindice(i,1), BajasBindice(i,2)) = MediaBajasB;
	end
	
	NombreCampo = 'Average thermal diffusivity [cm^2/s]';
	AlphaVal = 0.75;
	intervalo = [min(min(mProme)); max(max(mProme))];
	figure
	ImagenSuperpuestaB (DireccionImagen, DatoSele, xintervalo, yintervalo, TamHaz, AlphaVal, serieColor, tamPixel,  NombreCampo, intervalo)
end


