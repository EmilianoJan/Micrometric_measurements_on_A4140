function [] = PlotSalida2(Resu)
aux = Resu.MapaCor.*1e9;
aux = aux - mean(mean(aux));
imagesc(Resu.TamX.*1e6, Resu.TamX.*1e6 , aux);
axis tight;
axis equal;
% xlabel('X [\mum]')
% ylabel('Y [\mum]')
%colormap(map)
%set(gcf,'colormap',copper);
%gra.colormap = copper;

%caxis([-tamBarra tamBarra]);
a = colorbar;
a.Label.String = 'Z [nm]';

end 