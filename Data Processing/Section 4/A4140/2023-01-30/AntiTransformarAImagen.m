function [salida] = AntiTransformarAImagen(Entrada)
%proce = flip(Entrada, 2);
proce = rot90(Entrada);
proce = rot90(proce);
proce = rot90(proce);
salida = proce;
end