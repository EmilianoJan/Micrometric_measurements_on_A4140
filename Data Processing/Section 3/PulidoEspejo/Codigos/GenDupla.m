function [sali] = GenDupla(X, VectorVal)
puntos = ones(length(VectorVal), 1) .* X;
sali = [puntos ,VectorVal];
end
