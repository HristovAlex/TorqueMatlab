load quakedrift.mat
%%
Fs  = 4;                 % sample rate
dt = 1/Fs;                  % time differential
%t = (0:length(TestY)-1)*dt; % time vector

df = designfilt('differentiatorfir','FilterOrder',150,...
                'PassbandFrequency',0.05,'StopbandFrequency',0.2,...
                'SampleRate',Fs);
            
hfvt = fvtool(df,[1 -1],1,'magnitudedisplay','zero-phase','Fs',Fs);
legend(hfvt,'50th order FIR differentiator','Response of diff function');
%%
v1 = diff(TestY)/dt;
a1 = diff(v1)/dt;

v1 = [0; v1];
a1 = [0; 0; a1];

D = mean(grpdelay(df)); % filter delay
v2 = filter(df,[TestY; zeros(D,1)]);
v2 = v2(D+1:end);
a2 = filter(df,[v2; zeros(D,1)]);
a2 = a2(D+1:end);
v2 = v2/dt;
a2 = a2/dt^2;

TestLength=length(TestY);
plot(TestX,a1,TestX,a2)
plot(TestX(100:(length(TestY)-100)),a2(100:(length(TestY)-100)))

%helperFilterIntroductionPlot2(t,drift,v1,v2,a1,a2);

%%
findpeaks(a2(100:(length(TestY)-100)),TestX(100:(length(TestY)-100)),'MinPeakProminence',.4e-8);
xlabel('Field');
ylabel('D2Torque')
title('Find Prominent Peaks');  