%%
Fs  = 1000;                 % sample rate

FA = designfilt('differentiatorfir','FilterOrder',100,...
                'PassbandFrequency',0.48,'StopbandFrequency',5,...
                'SampleRate',Fs);
            
FB = designfilt('differentiatorfir','FilterOrder',100,...
                'PassbandFrequency',0.48,'StopbandFrequency',5,...
                'SampleRate',Fs);

FC = designfilt('differentiatorfir','FilterOrder',1400,...
                'PassbandFrequency',5,'StopbandFrequency',12,...
                'SampleRate',Fs);
            
FD = designfilt('differentiatorfir','FilterOrder',100,...
                'PassbandFrequency',0.48,'StopbandFrequency',3,...
                'SampleRate',Fs);
            
hfvt = fvtool(FC,[1 -1],1,'magnitudedisplay','zero-phase','Fs',Fs);
legend(hfvt,'FIR filter','Response of diff function');
%%

for trace = traceInfo.reducedtendegreetraces
    HellaInterp10(trace).A_FilteredD2=filtfilt(FA,HellaInterp10(trace).A_X_Interp);
    HellaInterp10(trace).B_FilteredD2=filtfilt(FB,HellaInterp10(trace).B_X_Interp);
    HellaInterp10(trace).C_FilteredD2=filtfilt(FC,HellaInterp10(trace).C_X_Interp);
    HellaInterp10(trace).D_FilteredD2=filtfilt(FD,HellaInterp10(trace).D_X_Interp);
end

figure('name', 'Second Derivative obtained by convolution on the grid 10 Degrees')
for trace = traceInfo.reducedtendegreetraces
    subplot(2,2,1)
    plot(HellaInterp10(trace).Field, HellaInterp10(trace).A_FilteredD2+HellaInterp10(trace).Temp/2e8)
    xlim([5,14]);ylim([0,1e-9]);
    
    hold on
    subplot(2,2,2)
    plot(HellaInterp10(trace).Field, -HellaInterp10(trace).B_FilteredD2+HellaInterp10(trace).Temp/2e8)
    xlim([5,14]);ylim([0,1e-9]);
    hold on
    subplot(2,2,3)
    plot(HellaInterp10(trace).Field, -HellaInterp10(trace).C_FilteredD2+HellaInterp10(trace).Temp/5e8)
    xlim([5,14]);ylim([0,1e-9]);
    hold on
    subplot(2,2,4)
    plot(HellaInterp10(trace).Field, HellaInterp10(trace).D_FilteredD2+HellaInterp10(trace).Temp/1e9)
    xlim([5,15]);ylim([0,0.7e-9]);
    hold on
end

clearvars trace ans Fs






%%
% findpeaks(a2(100:(length(TestY)-100)),TestX(100:(length(TestY)-100)),'MinPeakProminence',.4e-8);
% xlabel('Field');
% ylabel('D2Torque')
% title('Find Prominent Peaks');  