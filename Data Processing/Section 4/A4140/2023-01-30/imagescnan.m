function imagescnan(IM, color, xintervalo, yintervalo)
% function imagescnan(IM)
% -- to display NaNs in imagesc as white/black

% white
gris = 0.5;
if color == 0
	nanjet = [ gris,gris,gris; jet];
elseif color == 1
	nanjet = [ gris,gris,gris; gray];
else 
	nanjet = [ gris,gris,gris; parula];
end

nanjetLen = length(nanjet); 
pctDataSlotStart = 2/nanjetLen;
pctDataSlotEnd   = 1;
pctCmRange = pctDataSlotEnd - pctDataSlotStart;

dmin = nanmin(IM(:));
dmax = nanmax(IM(:));
dRange = dmax - dmin;   % data range, excluding NaN

cLimRange = dRange / pctCmRange;
cmin = dmin - (pctDataSlotStart * cLimRange);
cmax = dmax;
h1 = axes;
%set(h1, 'Ydir', 'reverse')
imagesc(xintervalo, yintervalo, flip(IM,1));
%set(gca,'YDir','normal')
set(gcf,'colormap',nanjet);
caxis([cmin cmax]);
axis square;


end