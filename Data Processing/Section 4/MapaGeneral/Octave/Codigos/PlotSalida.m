function [] = PlotSalida(Resu, tamBarra)
figure
aux = Resu.MapaEnderezado.*1e9;
aux = aux - min(min(aux));
imagesc(Resu.TamX.*1e6, Resu.TamX.*1e6 , aux)
axis equal;
xlabel('X [\mum]')
ylabel('Y [\mum]')
%colormap(map)
set(gcf,'colormap',jet);
%caxis([-tamBarra tamBarra]);
caxis([0 tamBarra]);
a = colorbar;
a.Label.String = 'Z [nm]';

end 