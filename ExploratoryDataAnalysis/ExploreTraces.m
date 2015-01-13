%%
%%%%%%%%                               EXPLORATORY ANALYSIS FOR TRACE
%%%%%%%%                               TYPE IDENTIFICATION
%%
%%
%all traces at 5 degrees
figure()
hold on
for trace = traceInfo.fivedegreetraces
    plot(Hella(trace).Field,Hella(trace).A_X)
end
hold off

%%
%all traces at 10 degrees
figure()
hold on
for trace = traceInfo.tendegreetraces
    plot(Hella(trace).Field,Hella(trace).A_X)
end

hold off

%%
% all the temperature sweeps plotted consecutively on a common time axis
figure()
hold on
timestampOffset = 0;
for trace = traceInfo.tempsweeptraces
    plot(Hella(trace).Timestamp+timestampOffset,Hella(trace).Temp);
    timestampOffset = timestampOffset + traceInfo.traceTime(trace-499);
end
 
hold off
clearvars timestampOffset trace

%%
%plot temperature values at the beginning and end of traces
figure()
hold on
plot(traceInfo.Index,traceInfo.EndMaxTemp,traceInfo.Index,traceInfo.EndMinTemp,traceInfo.Index,traceInfo.StartMaxTemp,traceInfo.Index,traceInfo.StartMinTemp)
hold off


%%
%plot Field values at the beginning and end of traces
figure()
hold on
plot(traceInfo.Index,traceInfo.StartField,traceInfo.Index,traceInfo.EndField)
hold off

%%
% all the temperatures from all sweeps plotted consecutively on a common time axis
figure()
hold on
timestampOffset = 0;
for trace = traceInfo.Index
    plot(Hella(trace).Timestamp+timestampOffset,Hella(trace).Temp); 
    
    timestampOffset = timestampOffset + traceInfo.traceTime(trace-499);
end
 
hold off
clearvars trace timestampOffset
%%
clearvars x y trace ans structname timestampOffset
