close all;
clear all;

%Este sript se encarga de generar las figuras ordenadas para la distribución del archivo itinerario principal

addpath('Codigos/') 


load('Mediciones/2023-03-04_Med_0.mat') %Pulido espejo referencia (va a paper) fig 1
%load('Mediciones/2023-02-28_Med_0.mat') %Superficie curvada bolilla (va a paper) fig 2
%load('Mediciones/2023-04-24_Med_1.mat') %Zona bien pulida, lija 1500 (va a paper) fig 3
%load('Mediciones/2023-04-25_Med_0') %Mediciones malas (va a paper subindice 1) Fig 4


%generado mediante AnalisisMuestrasPaper contiene las superficies
%de las muestras estudiadas.
load('ProcesadosPaperV3.mat') 


%IDifu_Fig = [0.04, 0.11]; %intervalo de visualización de las figuras
IDifu_Fig = [0.025, 0.075];
Tramo = 1; %establece el intervalo de mediciones que se va a estudiar
OmitirIniciales = 0;
GenFigFile = 0; %Establece si se generan los archivos de las figuras 1 = si, 0 = no


datos = Documento.DifusividadMapa;

datos = datos((OmitirIniciales+1):end, :);

tammapa = CalculaTamMapa(datos);
tammapaP = tammapa ;
rangoMapaPosta = max(datos(:,2)) - min(datos(:,2)) ;
rangoMapa = rangoMapaPosta + 0.001;



mapaRein = zeros(tammapaP,tammapaP);
mapaTiltX = zeros(tammapaP,tammapaP);
mapaTiltY = zeros(tammapaP,tammapaP);
mapaBuenaMed = zeros(tammapaP,tammapaP);
mapaReinBuena = zeros(tammapaP,tammapaP);
mDifuA = zeros(tammapaP,tammapaP);
mDifuB = zeros(tammapaP,tammapaP);
mDifuC = zeros(tammapaP,tammapaP);
mDiErA = zeros(tammapaP,tammapaP);
mDiErB = zeros(tammapaP,tammapaP);
mDiErC = zeros(tammapaP,tammapaP);
mFocus = zeros(tammapaP,tammapaP);
mErroAju = zeros(tammapaP,tammapaP);
mFotoVal = zeros(tammapaP,tammapaP);
mPPrueba = zeros(tammapaP,tammapaP);
Mtiempos  = zeros(tammapaP,tammapaP);

indiceAux = floor(tammapa/2) +1 ;
PosX = round((datos(:,2)+ rangoMapa/2 )  ./(rangoMapa/(tammapa-1))) + 1;
PosY = round((datos(:,3)+ rangoMapa/2 )  ./(rangoMapa/(tammapa-1))) + 1;


%calculado con referencia a fotografía caracterizada
yintervalo = [-96.13; 96.13]*(rangoMapaPosta/0.2);
xintervalo = [-96.13; 96.13]*(rangoMapaPosta/0.2);

[filas, columnasArchivo] = size(datos);

SignalExtra = 'Fototérmica [mV]';

switch columnasArchivo
	case 162
		ReinVC = 11;
		TiempMedi = 14;
		Fototermica = 89;
		tiltXVC = 56;
		tiltyVC = 62;
		focusVC = 70;
		difuAVC = 103;
		errAVC = 107;
		difuBVC = 120;
		errBVC = 124;
		difuCVC = 137;
		errCVC = 141;
		HazPrueba = 96;
		
	case 157
		ReinVC = 11;
		TiempMedi = 14;
		Fototermica = 0;
		tiltXVC = 60;
		tiltyVC = 66;
		focusVC = 43;
		difuAVC = 108;
		errAVC = 112;
		difuBVC = 125;
		errBVC = 129;
		difuCVC = 142;
		errCVC = 146;
		HazPrueba = 105;
		
	case 167
		%posible archivo de linea
		ReinVC = 11;
		TiempMedi = 14;
		Fototermica = 0;
		tiltXVC = 60;
		tiltyVC = 66;
		focusVC = 74;
		HazPrueba = 105;
		difuAVC = 108;
		errAVC = 112;
		difuBVC = 125;
		errBVC = 129;
		difuCVC = 142;
		errCVC = 146;
	
	case 468
		%posible archivo de linea
		disp('Medicion con submatrices, solo se muestra las alineadas')
		ReinVC = 11;
		TiempMedi = 14;
		Fototermica = 0;
		tiltXVC = 57;
		tiltyVC = 63;
		focusVC = 71;
		HazPrueba = 102;
		difuAVC = 105;
		errAVC = 109;
		difuBVC = 122;
		errBVC = 126;
		difuCVC = 139;
		errCVC = 143;
		
end

%Hasta le día 2023-03-21 CREO
% ReinVC = 11;
% ReinyeccionFinal = 94;
% BuenaMed = 4;
% tiltXVC = 60;
% tiltyVC = 66;
% focusVC = 74;
% difuAVC = 108;
% errAVC = 112;
% difuBVC = 125;
% errBVC = 129;
% difuCVC = 142;
% errCVC = 146;

%Desde el día 2023-03-22





IniP = (Tramo-1)*tammapa^2 +1 ;
FinP = (Tramo)*tammapa^2;

for e = IniP:FinP
	x = PosX(e);
	y = PosY(e);
	mapaRein(x,y) = datos(e,ReinVC);
	mapaBuenaMed(x,y) = datos(e,4);
	if Fototermica ~= 0
		mFotoVal(x,y) = datos(e,Fototermica);
	end
	mPPrueba(x,y) = datos(e,HazPrueba);
	%filtro por buenas mediciones
	%if (datos(e,4) == 1)
		
		mapaTiltX(x,y) = datos(e,tiltXVC); %9
		mapaTiltY(x,y) = datos(e,tiltyVC); %10
		mapaReinBuena(x,y) = datos(e,ReinVC);
		mFocus(x,y) = datos(e,focusVC);
		Mtiempos(x,y) = datos(e, TiempMedi);
		
		if(datos(e,errAVC) < 0.1)
			if (datos(e,difuAVC) < 0.15)
				mDifuA(x,y) = datos(e,difuAVC);
				mErroAju(x,y) = datos(e,errAVC);
				mDiErA(x,y) = datos(e,errAVC);
			end 
		end
		if(datos(e,errBVC) < 0.1)
			if (datos(e,difuBVC) < 0.15)
				mDifuB(x,y) = datos(e,difuBVC);
				mDiErB(x,y) = datos(e,errBVC);
			end 
		end
		if(datos(e,errCVC) < 0.1)
			if (datos(e,difuCVC) < 0.15)
				mDifuC(x,y) = datos(e,difuCVC);
				mDiErC(x,y) = datos(e,errCVC);
			end 
		end
		
	%end
end

mapaRein(mapaRein(:,:) == 0) = NaN;
mapaReinBuena(mapaReinBuena(:,:) == 0) = NaN;
mapaTiltX(mapaTiltX(:,:) == 0) = NaN;
mapaTiltY(mapaTiltY(:,:) == 0) = NaN;
mapaTiltX = mapaTiltX.*2/3; %corrección por máxima variación angular posible (pasa de 30º a 20º)
mapaTiltY = mapaTiltY.*2/3; %El dato que se encuentra en la tabla está mal y tiene que ser reescalado.

mDifuA(mDifuA(:,:) == 0) = NaN;
mDifuB(mDifuB(:,:) == 0) = NaN;
mDifuC(mDifuC(:,:) == 0) = NaN;
mDiErA(mDiErA(:,:) == 0) = NaN;
mDiErB(mDiErB(:,:) == 0) = NaN;
mDiErC(mDiErC(:,:) == 0) = NaN;
mFocus(mFocus(:,:) == 0) = NaN;
mFocus = mFocus.*6.56e-3*100*1e3;
mFocus(mFocus(:,:) < -200) = NaN;
mErroAju(mErroAju(:,:) == 0) = NaN;
mFotoVal(mFotoVal(:,:) == 0) = NaN;
mPPrueba(mPPrueba(:,:) == 0) = NaN;
Mtiempos(Mtiempos(:,:) == 0) = NaN;
Mtiempos = Mtiempos - min(min(Mtiempos));

%calculo el mapa promediado de difusividad térmica.
mProme = zeros(tammapaP,tammapaP);
mErPro = zeros(tammapaP,tammapaP);

for x = 1:tammapaP
	for y = 1:tammapaP
		cuenta = 0;
		avar = 0;
		erocu = 0;
		if isnan(mDifuA(x,y)) == 0
			avar = avar  + mDifuA(x,y);
			erocu = erocu + mDiErA(x,y);
			cuenta = cuenta +1;
		end
		
		if isnan(mDifuB(x,y)) == 0
			avar = avar  + mDifuB(x,y);
			erocu = erocu + mDiErB(x,y);
			cuenta = cuenta +1;
		end
		
		if isnan(mDifuC(x,y)) == 0
			avar = avar  + mDifuC(x,y);
			erocu = erocu + mDiErC(x,y);
			cuenta = cuenta +1;
		end
		
		if cuenta == 0 
			mProme(x,y) = NaN;
			mErPro(x,y) = NaN;
		else
			mProme(x,y) = avar/cuenta;
			mErPro(x,y) = erocu/cuenta;
		end
	end
end

TamHaz = 2.2e-6/2;
serieColor = 0;
NombreCampo = 'Difusividad promedio [cm^2/s]';
CantPixels = 850;
tamPixel = (96.13e-6*2*(0.01/0.1))/CantPixels;
DireccionImagen = 'AreaRecorte1.png';

xintervalob = (xintervalo - xintervalo(1)).*1e-6;
yintervalob = (yintervalo - yintervalo(1)).*1e-6;


mPromeb = mProme;
reshape(mPromeb,1,[]); 
mPromeb = mPromeb(~isnan(mPromeb));

mDif = mean(mPromeb);
stdDif = std(mPromeb);
Disper = (stdDif/mDif)*100;

disp(['D_{media} = ' , num2str(round(mDif, 3)) , '+/-', num2str(round(stdDif, 3)) , '[cm^2/s]  Disp = ' , num2str(round(Disper, 0)) , '%' ])

mErPro(mErPro(:,:) > 0.5) = 0.5;

if Fototermica ~= 0
	mFotoVal(mFotoVal(:,:) > 5) = 5;
end 




[Xpos, Ypos, Zpos] = Gen3DPlot (mapaTiltX, mapaTiltY, xintervalo, yintervalo);
if GenFigFile == 1
	print(gcf,'Imagenes/Fig12.png','-dpng' ,'-r94')
end

%realizo el estudio de la altura vs la difusividad.
ZVec = reshape(Zpos,[],1);
DifVec = reshape(mProme,[],1);
DifVecTotal = DifVec;

ZVec = ZVec(~isnan(DifVec));
DifVec = DifVec(~isnan(DifVec));


%genero el archivo stl
if GenFigFile == 1
	surf2stl('Imagenes/Salida.stl',Xpos, Ypos, Zpos,'ascii')
end

%Hasta acá el script fototérmico



%calculo diferentes estadísticos con la información que tengo. La idea es después guardar esa información
%como una línea de texto.

[DMed, DDes, DDis] = EstadisticosMapa(mProme);
[EMed, EDes, EDis] = EstadisticosMapa(mErPro);
[TxMed, TxDes, TxDis] = EstadisticosMapa(mapaTiltX);
[TyEMed, TyEDes, TyEDis] = EstadisticosMapa(mapaTiltY);


%calculo vector temporal: 
IniP = (Tramo-1)*tammapa^2 +1 ;
FinP = (Tramo)*tammapa^2;
TempoMed = Documento.DifusividadMapa(IniP:FinP, TiempMedi) ;
TempoMed = TempoMed(~isnan(TempoMed));
DeltaT = TempoMed(2:end) - TempoMed(1:end-1);
TMed = mean(DeltaT);
TDes = std(DeltaT);


%Hago print de los numeros
prueba = num2str([DMed, DDes, DDis, EMed, EDes, EDis, TxMed, TxDes, TxDis, TyEMed, TyEDes, TyEDis, TMed, TDes]);
%prueba = num2str([DMed, DDes, DDis]);
sali = strrep(prueba, '  ', ' ');
sali = strrep(sali, '  ', ' ');
sali = strrep(sali, '  ', ' ');
sali = strrep(sali, '  ', ' ');
sali = strrep(sali, '  ', ' ');
sali = strrep(sali, '  ', ' ');
sali = strrep(sali, '  ', ' ');
sali = strrep(sali, '  ', ' ');
sali = strrep(sali, ' ', '; ')

%calculo la tasa de aciertos.
TasaAli = length(DifVec) / length( DifVecTotal)


%genero la figura final acá

f = figure;
subplot(1,3,1)

%D (difusividad)
imagescnan(TransformarAImagen(mProme),0, xintervalo, yintervalo)
xlabel('X position [\mum]')
ylabel('Y position [\mum]')
%title('a)')
a = colorbar;
a.Label.String = 'Thermal Diffusivity [cm^2/s]';
caxis(IDifu_Fig);


% ax3 =subplot(2,2,2);
% %h (alturas)
% imagescnan(TransformarAImagen(Zpos),0, xintervalo, yintervalo)
% xlabel('X position [\mum]')
% ylabel('Y position [\mum]')
% a = colorbar;
% a.Label.String = 'Height [\mum]';


subplot(1,3,2)
%histograma
histogram(mPromeb, 15)

ListadoDifu = reshape(mPromeb, [], 1);
DifuMedia = mean(ListadoDifu);

hold on
line(DifuMedia*[1 1],ylim , 'Color',[0,0,0] ,'LineWidth',2, 'LineStyle' , '--')

grid on
grid minor
xlabel('Thermal Diffusivity [cm^2/s]')
ylabel('Counts')

ax4 = subplot(1,3,3);
PlotSalida2(EM1a000);
xlabel('X position [\mum]')
ylabel('Y position [\mum]')
colormap(ax4, copper);

f.Position = [100 100 700 400];
print(gcf,'PulidoEspejoV2.png','-dpng' ,'-r300')







