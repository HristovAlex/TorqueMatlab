function [ smoothed, smoothed_D, smoothed_D2 ] = gConvolve( raw, sigma )
%gConvolve convolves with gaussian of SD sigma and gives derivatives

filtergrid=-(10*sigma):(10*sigma);

filter = 1/sqrt(2*pi*sigma^2) * exp(- filtergrid.^2/(2*sigma^2));
smoothed=conv(raw,filter,'same');

Dfilter = 1/sqrt(2*pi*sigma^6)*(-filtergrid).* exp(- filtergrid.^2/(2*sigma^2));
smoothed_D=conv(raw,Dfilter,'same');

D2filter = 1/sqrt(2*pi*sigma^10)*(filtergrid.^2-sigma^2).* exp(- filtergrid.^2/(2*sigma^2));
smoothed_D2=conv(raw,D2filter,'same');

end

