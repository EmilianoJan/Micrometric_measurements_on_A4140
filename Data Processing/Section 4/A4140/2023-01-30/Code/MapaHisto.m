function MapaHisto(Mapa, TituloVal, unidades, EjeX)

mPromeb = Mapa;
reshape(mPromeb,1,[]); 
mPromeb = mPromeb(~isnan(mPromeb));

mDif = mean(mPromeb);
stdDif = std(mPromeb);
Disper = (stdDif/mDif)*100;

histogram(mPromeb, 20)
title (strcat(TituloVal, '_{media} = ' , num2str(round(mDif, 3)) , '+/-', num2str(round(stdDif, 3)) , unidades , ' Disp = ' , num2str(round(Disper, 0)) , '%' ));
grid on
grid minor
xlabel(EjeX)
end