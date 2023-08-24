function [XSali, Yprima] = DerivadaDiscreta(X, Y)
%Falta terminar
%https://www.olympus-ims.com/en/metrology/surface-roughness-measurement-portal/parameters/#!cms[focus]=001 
indice = 1;
XSali = X(1:end-1);
Yprima = zeros(length(X)-1,1);
for i = 1:(length(X)-1)
	
	avar = (Y(indice +1) - Y(indice))/(X(indice +1) - X(indice));
	Yprima(indice) =  avar;
	indice = indice +1;
end

end