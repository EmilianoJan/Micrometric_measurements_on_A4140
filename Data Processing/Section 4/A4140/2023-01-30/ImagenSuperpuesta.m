function ImagenSuperpuesta (DireccionImagen, mapa, xintervalo, yintervalo,TamHaz, AlphaVal, serieColor, tamPixel,  NombreCampo)

mProme = flip(mapa, 1);
[xvec,yvec,valores] = ConvertirASerie(mProme,  xintervalo, yintervalo);

Valores = valores;
PuntosX = xvec;
PuntosY = yvec;

%function ImagenSuperpuesta (DireccionImagen, PuntosX, PuntosY, Valores, TamHaz, AlphaVal, serieColor, tamPixel,  NombreCampo)


C =  imread(DireccionImagen);
%aaaa = (C(:,:,1)+C(:,:,2)+C(:,:,3))./3;
r = double(C(:,:,1));
g = double(C(:,:,2));
b = double(C(:,:,3));

aaaa = (r +g+b)./3;
aMax = max(max(aaaa));
aMin = min(min(aaaa));
%aMax = 255;
%aMin = 0;
aMax = aMax-aMin;
aaaa = (aaaa-aMin).*(255/aMax);

C(:,:,1) = aaaa;
C(:,:,2) = aaaa;
C(:,:,3) = aaaa;

[imaFila, imaCol] = size(r);

xini = [0 imaCol].*tamPixel.*1e6;
yini = [0 imaFila].*tamPixel.*1e6;
image(xini,yini,C)
hold on

auxa = ones(length(Valores),1).*TamHaz.*1e6;

Vec = [PuntosX.*1e6, PuntosY.*1e6, Valores, auxa];
B = sortrows(Vec, 3);
for e = 1:length(PuntosX)
    %plot(B(e, 1),B(e, 2), '.', 'color' , genColor(min(B(:,3)), max(B(:,3)), B(e, 3)) )
    % Display the circles.
    %hold on
	if ~isnan(B(e, 3))
		s = circles(B(e, 1),B(e, 2),B(e, 4),'Color', genColor(min(B(:,3)), max(B(:,3)), B(e, 3), serieColor), 'edgecolor', [0 0 0]);
		%hold off
		%alpha(.1)
		alpha(s,AlphaVal)
	end
end 
if serieColor == 1
    colormap gray
else
    colormap jet
end 
%colormap gray
h = colorbar;
caxis([min(B(:,3)) max((B(:,3)))])
ylabel('Y position [\mum]')
xlabel('X position [\mum]')

%ylabel(h, 'Difusividad cm^2/s')

%ylabel(h, 'Error ajuste')

%ylabel(h, 'Frecuencia de corte')

%ylabel(h, 'Reinyección [mV]')
ylabel(h, NombreCampo)
axis equal

end