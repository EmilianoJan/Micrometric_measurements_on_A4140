function [Media, Desvio, Dispersion] = EstadisticosMapa(Mapa)

mPromeb = Mapa;
reshape(mPromeb,1,[]); 
mPromeb = mPromeb(~isnan(mPromeb));

Media = mean(mPromeb);
Desvio = std(mPromeb);
Dispersion = (Desvio/Media)*100;

end