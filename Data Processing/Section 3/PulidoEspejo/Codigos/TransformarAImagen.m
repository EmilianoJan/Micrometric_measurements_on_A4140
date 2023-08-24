function [salida] = TransformarAImagen(Entrada)

proce = rot90(Entrada);
salida = flip(proce, 2);

end