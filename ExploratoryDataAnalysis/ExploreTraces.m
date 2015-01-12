%%
%%%%%%%%                               EXPLORATORY ANALYSIS FOR TRACE
%%%%%%%%                               TYPE IDENTIFICATION
%%
%%
%all traces at 5 degrees
figure()
hold on
for trace = fivedegreetraces
    plot(Hella{trace}.Field,Hella{trace}.A_X)
end
hold off

%%
%all traces at 10 degrees
figure()
hold on
for trace = tendegreetraces
    plot(Hella{trace}.Field,Hella{trace}.A_X)
end

hold off

%%
% all the temperature sweeps plotted consecutively on a common time axis
figure()
hold on
timestampOffset = 0;
for trace = tempsweeptraces
    plot(Hella{trace}.Timestamp+timestampOffset,Hella{trace}.Temp);
    timestampOffset = timestampOffset + traceInfo.traceTime(trace-499);
end
 
hold off


%%
%plot temperature values at the beginning and end of traces
figure()
hold on
plot(tracenumbers,traceInfo.EndMaxTemp,tracenumbers,traceInfo.EndMinTemp,tracenumbers,traceInfo.StartMaxTemp,tracenumbers,traceInfo.StartMinTemp)
hold off


%%
%plot Field values at the beginning and end of traces
figure()
hold on
plot(tracenumbers,traceInfo.StartField,tracenumbers,traceInfo.EndField)
hold off

%%
% all the temperatures from all sweeps plotted consecutively on a common time axis
figure()
hold on
timestampOffset = 0;
for trace = traceInfo.Index
    plot(Hella{trace}.Timestamp+timestampOffset,Hella{trace}.Temp); 
    
    timestampOffset = timestampOffset + traceInfo.traceTime(trace-499);
end
 
hold off

%%
clearvars x y trace ans structname timestampOffset