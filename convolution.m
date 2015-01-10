%%convolution

raw=Hella{537}.C_X;
field=Hella{537}.Field;

sigma = 4;
filtergrid=-(10*sigma):(10*sigma);

%%

filter = 1/sqrt(2*pi*sigma^2) * exp(- filtergrid.^2/(2*sigma^2));

plot(filtergrid,filter);

smoothed=conv(raw,filter,'same');

% figure
% plot(field,smoothed);


figure
hold on
plot(field,smoothed-raw);
xlim([2,16])


filter = 1/sqrt(2*pi*sigma^2) * exp(- filtergrid.^2/(2*sigma^2));
smoothedRes=conv(smoothed-raw,filter,'same');
plot(field,smoothedRes);
xlim([2,16])
hold off

%%

D2filter = 1/sqrt(2*pi*sigma^10)*(filtergrid.^2-sigma^2).* exp(- filtergrid.^2/(2*sigma^2));
figure
plot(filtergrid,D2filter)
figure
smoothedD2=conv(raw,D2filter,'same');
plot(field,smoothedD2);
xlim([2,16])
hold off