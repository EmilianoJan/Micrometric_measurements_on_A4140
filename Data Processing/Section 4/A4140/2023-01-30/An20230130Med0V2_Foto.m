%close all;
%clear all;

%En este script se realiza una imagen de la zona estudiada (empleando matlab)
%load('2023-01-11_Med_2Foto1.mat')
%rango = datos(2387:3287,:);

 load('2023-01-30_Med_0Foto1.mat');
 rango = datos(7401:end,:);

%load('2023-01-31_Med_0Foto1.mat');
%rango = datos(1166:11165,:);
%rango = datos(11165:21265,:);

tammapa = floor(sqrt(length(rango)));
tammapaP = tammapa ;
rangoMapa = 0.201;
rangoMapaPosta = 0.2;

% rangoMapa = 0.601;
% rangoMapaPosta = 0.6;

mapaRein = zeros(tammapaP,tammapaP);

indiceAux = floor(tammapa/2) +1 ;

PosX = floor(round(rango(:,2), 6)./(rangoMapa/tammapa)) + indiceAux;
PosY = floor(round(rango(:,3), 6)./(rangoMapa/tammapa)) + indiceAux;

%calculado con calibración interna
% yintervalo = [-1500*rangoMapaPosta/2, 1500*rangoMapaPosta/2];
% xintervalo = [-1500*rangoMapaPosta/2, 1500*rangoMapaPosta/2];

%calculado con referencia a fotografía caracterizada
yintervalo = [-96.13; 96.13];
xintervalo = [-96.13; 96.13];

for e = 1:length(rango)
	x = PosX(e);
	y = PosY(e);
	mapaRein(x,y) = rango(e,4);
end
mapaRein = TransformarAImagen(mapaRein);

%renormalizo la imagen
media = mean(mean(mapaRein));
desvio = std(std(mapaRein));
% mapaRein = mapaRein-min(min(mapaRein));
% mapaRein = mapaRein.^(1/2);
%mapaRein = log(log(mapaRein.*1000));
%mapaRein = exp(-(mapaRein- media).^2./(2*desvio^2))./(desvio* sqrt(2*pi));
figure

imagescnan(mapaRein,1, xintervalo, yintervalo)
%colourmap( [0 0 0; parula(256)] )
xlabel('Pos Y [um]')
ylabel('Pos X [um]')
title('Reinyección')
axis square;









