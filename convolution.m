


%%
for trace = tendegreetraces
    [Hella{trace}.A_Conv, Hella{trace}.A_ConvD, Hella{trace}.A_ConvD2]=...
        gConvolve(Hella{trace}.A_X,8);
end

figure()
for trace = tendegreetraces
   if traceInfo.MaxField(trace-499)>10 && traceInfo.MinField(trace-499)<10
       plot(Hella{trace}.Field, Hella{trace}.A_ConvD2 + traceInfo.TraceTemp(trace-499)/20000000);
       hold on
   end
end
xlim([8,15])
hold off
clearvars trace ans

%%
for trace = fivedegreetraces
    [Hella{trace}.A_Conv, Hella{trace}.A_ConvD, Hella{trace}.A_ConvD2]=...
        gConvolve(Hella{trace}.A_X,8);
end

figure()
for trace = fivedegreetraces
   if traceInfo.MaxField(trace-499)>10 && traceInfo.MinField(trace-499)<10
       plot(Hella{trace}.Field, Hella{trace}.A_ConvD2 + traceInfo.TraceTemp(trace-499)/20000000);
       hold on
   end
end
xlim([8,15])
hold off
clearvars trace ans
