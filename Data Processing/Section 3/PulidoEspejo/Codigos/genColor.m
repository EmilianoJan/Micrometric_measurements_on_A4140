function [color] = genColor (min, max, valor, serie)
x = 1:250;
if serie == 1
    colorMap = gray(length(x));
else
    colorMap = jet(length(x));   
end 
indice = floor((valor-min)/(max-min)*250);
if indice > 250
    indice = 250;
end 

if indice < 1
    indice = 1;
end
color = colorMap(indice, :);
end