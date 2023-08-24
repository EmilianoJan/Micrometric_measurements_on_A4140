function [Estadi] = CalculoEstadisticosMatriz (dx, dy, Datos)
%función que admite una matriz de datos y calcula los valores de rugosidad
ind = 1;

Ra = 0;
Rku = 0;
vMaterialRatio = 0;
Rq = 0;
Rdq = 0;
Rsk = 0;


lRa = 0;
lRku = 0;
lvMaterialRatio = 0;
lRq = 0;
lRdq = 0;
lRsk = 0;
lRSm = 0;
lRc = 0;

mlRa = 0;
mlRku = 0;
mlvMaterialRatio = 0;
mlRq = 0;
mlRdq = 0;
mlRsk = 0;
mlRSm = 0;
mlRc = 0;



[tamx, tamy] = size(Datos);
SerieX = transpose((1:tamx).*dx);

Realineada = zeros(tamx,tamy);

for i = 1:tamy
	SerieZ =  Datos(:, ind);
	%SerieZ = Datos(((ind-1)*128 +1):(ind*128),3);
	
	Ra =  Ra + ArithmeticMeanDeviation(SerieX, SerieZ);
	Rku = Rku + Kurtosis(SerieX, SerieZ);
	media = (max(SerieZ) - min(SerieZ)) /2 + min(SerieZ);
	vMaterialRatio = vMaterialRatio + MaterialRatio(SerieX, SerieZ, media);
	Rq = Rq + RootMeanSquareDeviation(SerieX, SerieZ);
	Rdq = Rdq + RootMeanSquareSlope(SerieX, SerieZ);
	Rsk = Rsk + Skewness(SerieX, SerieZ);
	
	
	%resto la recta;
	mdl = fitlm(SerieX,SerieZ);
	SerieZSal = SerieZ - (table2array(mdl.Coefficients(2,1)).*SerieX + table2array(mdl.Coefficients(1,1)));
	
	lRa =  lRa + ArithmeticMeanDeviation(SerieX, SerieZSal);
	lRku = lRku + Kurtosis(SerieX, SerieZSal);
	lmedia = (max(SerieZSal) - min(SerieZSal)) /2 + min(SerieZSal);
	lvMaterialRatio = lvMaterialRatio + MaterialRatio(SerieX, SerieZSal, media);
	lRq = lRq + RootMeanSquareDeviation(SerieX, SerieZSal);
	lRdq = lRdq + RootMeanSquareSlope(SerieX, SerieZSal);
	lRsk = lRsk + Skewness(SerieX, SerieZSal);
	lRSm = lRSm + MeanWidth(SerieX, SerieZSal);
	lRc = lRc + MeanHeight(SerieZSal);
	
	mlRa =  max([mlRa , ArithmeticMeanDeviation(SerieX, SerieZSal)]);
	mlRku = max([mlRku , Kurtosis(SerieX, SerieZSal)]);
	mlvMaterialRatio = max([lvMaterialRatio , MaterialRatio(SerieX, SerieZSal, media)]);
	mlRq = max([mlRq , RootMeanSquareDeviation(SerieX, SerieZSal)]);
	mlRdq = max([mlRdq , RootMeanSquareSlope(SerieX, SerieZSal)]);
	mlRsk = max([mlRsk , Skewness(SerieX, SerieZSal)]);
	mlRSm = max([mlRSm , MeanWidth(SerieX, SerieZSal)]);
	mlRc = max([mlRc , MeanHeight(SerieZSal)]);
	
	Realineada(:,ind) = SerieZSal;
	
	ind = ind +1;
end

Estadi.Sq = RootMeanSquareHeight(dx, dy, Datos);

MapaPlano = EnderezarMapa(Datos);
SqV2 = RootMeanSquare_Superficie(dx, dy, MapaPlano);
FFTSup = FFT_Analisis(dx, dy, MapaPlano);

TamX = [min(Datos(:,2)), max(Datos(:,2))];
TamY = [min(Datos(:,2)), max(Datos(:,2))];

%calculo los promedios y devuelvo el dato

Estadi.Ra = Ra/128;
Estadi.Rku = Rku/128;
Estadi.sMaterialRatio = vMaterialRatio/128;
Estadi.Rq = Rq/128;
Estadi.Rdq = Rdq/128;
Estadi.Rsk = Rsk/128;


Estadi.lRa = lRa/128;
Estadi.lRku = lRku/128;
Estadi.lsMaterialRatio = lvMaterialRatio/128;
Estadi.lRq = lRq/128;
Estadi.lRdq = lRdq/128;
Estadi.lRsk = lRsk/128;

Estadi.mlRa = mlRa;
Estadi.mlRku = mlRku;
Estadi.mlsMaterialRatio = mlvMaterialRatio;
Estadi.mlRq = mlRq;
Estadi.mlRdq = mlRdq;
Estadi.mlRsk = mlRsk;

Estadi.lRSm = lRSm/128;
Estadi.lRc = lRc/128;
Estadi.MapaCor = Realineada;
Estadi.Original = Datos;
Estadi.MapaEnderezado = MapaPlano;
Estadi.SqV2 = SqV2;
Estadi.TamX = TamX;
Estadi.TamY = TamY;
Estadi.dx = dx;
Estadi.dy = dy;
Estadi.FFTSup = FFTSup;

end