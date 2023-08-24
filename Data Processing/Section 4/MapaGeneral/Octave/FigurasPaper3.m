close all;
clear all;

addpath('Codigos/') 
%Figuras del paper 3
%que compara la superficie de la muestra con su rugosidad
load('MapasEstudio30_06_2023V2.mat')


tammapa = 512;
Paso = 102;


%genero la tabla
datos = table2array(A4140a001);
[dx,dy, tabla1] = GenTabla(datos, tammapa);
xintervalo = [0 dx*tammapa*1e6];
dxFino = dx;

datos = table2array(A4140a002);
[dx,dy, tabla2] = GenTabla(datos, 256);

%busco hacer imagenes comparativas entre la imagen en Z y los valores de rugosidad.

mapaRugo1 = zeros(10,10);
mapaRugo2 = zeros(10,10);

for x = 1:10
	for y = 1:10
		mapaRugo2(x,y) = RA4140A002{x,y}.SqV2;
	end
end



figure
%subplot(1,2,1)
imagescnan(tabla2.*1e6,0, xintervalo, xintervalo)
ylabel('Y Position [\mum]')
xlabel('X Position [\mum]')

colormap (copper);
a = colorbar;
a.Label.String = 'Height [\mum]';
%title ('a) Alturas')


figure

z = tabla2.*1e6;
[x,y] =  meshgrid(1:256);
x = (x .* xintervalo(2))./256;
y = (y .* xintervalo(2))./256;

s = surf(x,y,z);
s.EdgeColor = 'none';
s.FaceLighting  = 'gouraud';

ylabel('Y Position [\mum]')
xlabel('X Position [\mum]')

colormap (copper);
a = colorbar;
a.Label.String = 'Height [\mum]';


%Muestro una perfilometría de la muestra
figure
zPos = z(:,128);
zPos = zPos - min(zPos);
Xpos = flip(transpose(x(128, :)));
plot(Xpos, zPos, 'linewidth', 2)
grid on
grid minor
ylabel('Height [\mum]')
xlabel('X Position [\mum]')


figure
%subplot(1,2,2)
imagescnan(mapaRugo2,0, xintervalo, xintervalo)
ylabel('Y Position [\mum]')
xlabel('X Position [\mum]')
a = colorbar;
a.Label.String = 'Sq [nm]';
%title ('b) Root Mean Square')

ListadoRugo = reshape(mapaRugo2, [], 1);
RugoMedia = mean(ListadoRugo);

figure
histogram(ListadoRugo, 12)
grid on 
grid minor
xlabel('Sq [nm]');
ylabel('Counts')
line(RugoMedia*[1 1],ylim , 'Color',[0,0,0] ,'LineWidth',3, 'LineStyle' , '--')

















