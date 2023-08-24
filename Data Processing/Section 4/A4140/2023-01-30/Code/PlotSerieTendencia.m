function PlotSerieTendencia(xdat, ydat, labelx, labely)

figure('Position',[100 100 600 400]);
clear g
g(1,1) = gramm('x', xdat, 'y',  ydat);
g(1,1).set_color_options()
g(1,1).geom_point();
g(1,1).update();
g(1,1).stat_smooth();
g(1,1).set_color_options('chroma',0,'lightness',30);
g(1,1).set_names('x',labelx,'y',labely);
g(1,1).axe_property('Ygrid','on');
g(1,1).axe_property('Xgrid','on');

g.draw()
end