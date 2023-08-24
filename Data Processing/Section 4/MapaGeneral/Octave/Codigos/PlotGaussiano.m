function PlotGaussiano (mapa, xintervalo, yintervalo,TamHaz, PuntosLado, Campo)
%PLOTGAUSSIANO genera una figura con un promedio gaussiano en el cual interviene el tamaño del haz
%	mapa = Matriz bidimensional con la información a graficar
%	xintervalo = Intervalo en la dirección X
%	yintervalo = Intervalo en la dirección Y
%	TamHaz = Tamaño del haz Gaussiano con el cual se generó el mapa
%	PuntosLado = Indica el tamaño de la matriz en la dirección X
%	Campo = Etiqueta que aparecerá al lado de la escala de colores

mProme = flip(mapa, 1);
[xvec,yvec,valores] = ConvertirASerie(mProme,  xintervalo, yintervalo);

Valores = valores;
PuntosX = xvec;
PuntosY = yvec;

pasox = (xintervalo(2) - xintervalo(1))/ PuntosLado;
pasoy = (yintervalo(2) - yintervalo(1))/ PuntosLado;

minPasoX = xintervalo(1)/pasox;
minPasoY = yintervalo(1)/pasoy;

PromVal = zeros(PuntosLado,PuntosLado);
Valor = zeros(PuntosLado,PuntosLado);
pasoTamHaz = TamHaz/pasox;

for punto = 1:length(Valores)
	
	pvalo = Valores(punto);
	px = PuntosX(punto)/pasox - minPasoX;
	py = PuntosY(punto)/pasoy- minPasoY;
	
	if ~isnan(pvalo)
		for x = 1:PuntosLado
			for y = 1: PuntosLado
				baseVal = exp(- ((x - px)^2 + (y - py)^2)/(2*pasoTamHaz^2));
				PromVal(x,y) = PromVal(x,y) + baseVal;
				Valor(x,y) = Valor(x,y) + pvalo*baseVal;
			end 
		end
	end 
end 


CalculoFinal = Valor./PromVal;

xv = linspace(xintervalo(1).*1e6, xintervalo(2).*1e6, PuntosLado);
yv = linspace(yintervalo(1).*1e6, yintervalo(2).*1e6, PuntosLado);
[X,Y] = meshgrid(xv, yv);


surf(X, Y, CalculoFinal);
grid on
%set(gca, 'ZLim',[0 max(z)])
shading interp
hold on
%stem3(x, y, z, 'Color', [0 0 0], 'LineWidth',2)
% for ii=1:length(x)
%       text(x(ii)+0.5,y(ii), max(z), num2str(z(ii),4))
% end
grid on
axis tight
colormap jet
h = colorbar;
ylabel(h, Campo)
xlabel('Posición [\mum]')
ylabel('Posición [\mum]')


end























