function [dx,dy, tabla] = GenTabla(VectorPos, Fila)
%rutina que genera una tabla con los valores en Z.
%también devuelve el tamaño del paso en X e Y.

tabla = zeros(Fila, Fila);

x = 1;
y = 1;
for i = 1:length(VectorPos)
	tabla(x,y) = VectorPos(i, 3);
	x = x +1;
	if x == (Fila +1)
		y = y +1;
		x = 1;
	end
end

dx = VectorPos(2,1) - VectorPos(1,1);
dy = VectorPos(Fila+1,2) - VectorPos(Fila,2);

end