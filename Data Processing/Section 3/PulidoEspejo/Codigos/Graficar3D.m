function Graficar3D (mapa, xintervalo, yintervalo, Campo)

mProme = flip(mapa, 1);
[xvec,yvec,valores] = ConvertirASerie(mProme,  xintervalo, yintervalo);

z = valores;
x = xvec;
y = yvec;

%z = dif(:,5) + tamFiltrado(:,12 ) + tamFiltrado(:,16);

superVector = [x , y, z];
superVector = superVector(not(isnan( superVector(:,1))), :);
superVector = superVector(not(isnan( superVector(:,2))), :);
superVector = superVector(not(isnan( superVector(:,3))), :);
superVector = superVector(superVector(:,3) ~=0,:);

x = superVector(:,1);
y = superVector(:,2);
z = superVector(:,3);

figure
xv = linspace(min(x), max(x), 150);
yv = linspace(min(y), max(y), 150);
[X,Y] = meshgrid(xv, yv);
Z = griddata(x,y,z,X,Y, 'nearest'); %El más claro
%Z = griddata(x,y,z,X,Y, 'V4'); %Esteticamente lindo
%Z = griddata(x,y,z,X,Y, 'linear'); %

surf(X, Y, Z);
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
h = colorbar;
ylabel(h, Campo)
xlabel('Posición [\mum]')
ylabel('Posición [\mum]')

end