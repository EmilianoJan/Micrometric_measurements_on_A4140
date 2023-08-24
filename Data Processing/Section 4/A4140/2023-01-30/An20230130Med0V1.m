close all;
clear all;

%en este script se busca estudiar las mediciones iniciadas el 30/01/2023 sobre la muestra de A4140.
%las mediciones resultaron muy satisfactorias y tienen sentido.



load('2023-01-30_Med_0.mat');
%datos = datos(38:end,:);

tammapa = 15;
tammapaP = tammapa ;
rangoMapa = 0.201;
rangoMapaPosta = 0.2;

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

PosX = round(round(datos(:,2), 6)./(rangoMapa/tammapa)) + indiceAux;
PosY = round(round(datos(:,3), 6)./(rangoMapa/tammapa)) + indiceAux;

%calculado con calibración interna
% yintervalo = [-1500*rangoMapaPosta/2, 1500*rangoMapaPosta/2];
% xintervalo = [-1500*rangoMapaPosta/2, 1500*rangoMapaPosta/2];

%calculado con referencia a fotografía caracterizada
yintervalo = [-96.13; 96.13];
xintervalo = [-96.13; 96.13];

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

mapaRein = TransformarAImagen(mapaRein);
mapaReinBuena = TransformarAImagen(mapaReinBuena);
mapaTiltX = TransformarAImagen(mapaTiltX);
mapaTiltY = TransformarAImagen(mapaTiltY);
mDifuA = TransformarAImagen(mDifuA);
mDifuB = TransformarAImagen(mDifuB);
mDifuC = TransformarAImagen(mDifuC);
mFocus = TransformarAImagen(mFocus);
mErroAju = TransformarAImagen(mErroAju);

figure

imagescnan(mapaRein,0, xintervalo, yintervalo)
%colourmap( [0 0 0; parula(256)] )
xlabel('Pos Y [um]')
ylabel('Pos X [um]')
title('Reinyección')

figure
imagescnan(mapaReinBuena,0, xintervalo, yintervalo)
%colourmap( [0 0 0; parula(256)] )
xlabel('Pos Y [um]')
ylabel('Pos X [um]')
title('Reinyección (solo buenas)')

figure
%subplot(1,2,1)
imagescnan(mapaTiltX,0, xintervalo, yintervalo)
%colourmap( [0 0 0; parula(256)] )
xlabel('Pos Y [um]')
ylabel('Pos X [um]')
a = colorbar;
a.Label.String = 'Tilt X [º]';

figure
%subplot(1,2,2)
imagescnan(mapaTiltY,0, xintervalo, yintervalo)
%colourmap( [0 0 0; parula(256)] )
xlabel('Pos Y [um]')
ylabel('Pos X [um]')
a = colorbar;
a.Label.String = 'Tilt Y [º]';


figure
imagescnan(mDifuA,0, xintervalo, yintervalo)
%colourmap( [0 0 0; parula(256)] )
xlabel('Pos Y [um]')
ylabel('Pos X [um]')
a = colorbar;
a.Label.String = 'Difusividad A [cm^2/s]';
%title('Difusividad')

figure
imagescnan(mDifuB,0, xintervalo, yintervalo)
%colourmap( [0 0 0; parula(256)] )
xlabel('Pos Y [um]')
ylabel('Pos X [um]')
a = colorbar;
a.Label.String = 'Difusividad B [cm^2/s]';

figure
imagescnan(mDifuC,0, xintervalo, yintervalo)
%colourmap( [0 0 0; parula(256)] )
xlabel('Pos Y [um]')
ylabel('Pos X [um]')
a = colorbar;
a.Label.String = 'Difusividad C [cm^2/s]';




figure
imagescnan(mFocus,0, xintervalo, yintervalo)
%colourmap( [0 0 0; parula(256)] )
xlabel('Pos Y [um]')
ylabel('Pos X [um]')
a = colorbar;
a.Label.String = 'Focus L2 [\mum]';


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
imagescnan(mProme,0, xintervalo, yintervalo)
xlabel('Pos Y [um]')
ylabel('Pos X [um]')
a = colorbar;
a.Label.String = 'Difusividad promedio [cm^2/s]';


figure
imagescnan(mErroAju,0, xintervalo, yintervalo)
%colourmap( [0 0 0; parula(256)] )
xlabel('Pos Y [um]')
ylabel('Pos X [um]')
a = colorbar;
a.Label.String = 'Error ajuste chi^2';





