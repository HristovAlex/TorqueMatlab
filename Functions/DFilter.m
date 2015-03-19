function [ filtd ] = DFilter( passband,stopband,order,traceInfo,HellaInterp10)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Fs  = 1000;                 % sample rate

FC = designfilt('differentiatorfir','FilterOrder',order,...
    'PassbandFrequency',passband,'StopbandFrequency',stopband,...
    'SampleRate',Fs);

for trace = traceInfo.reducedtendegreetraces
    HellaInterp10(trace).D_FilteredD2=filtfilt(FC,HellaInterp10(trace).D_X_Interp);
end



figure('name', strcat('Order:', num2str(order),' Passband:',  num2str(passband),'T^{-1} Stopband:', num2str(stopband),'T^{-1}') )
for trace = traceInfo.reducedtendegreetraces
    plot(HellaInterp10(trace).Field, HellaInterp10(trace).D_FilteredD2+HellaInterp10(trace).Temp/1e9)
    xlim([5,14]);ylim([0,1e-9]);
    hold on
    
end
    filtd=HellaInterp10;
end