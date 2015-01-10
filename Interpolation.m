%%
%Program for generating SmoothedData

for trace = tendegreetraces
    [Hella{trace}.A_Fit, Hella{trace}.A_gof]=createFit(Hella{trace}.Field,Hella{trace}.A_X,.999,0,num2str(trace));
end

%%
standardMesh=0.5:0.001:18;
for trace = tendegreetraces
    Hella{trace}.A_X_GRID = Hella{trace}.A_Fit(standardMesh);
    [Hella{trace}.A_X_GRID_D,Hella{trace}.A_X_GRID_DD] = differentiate(Hella{trace}.A_Fit, standardMesh);
end

%%
figure()
for trace = tendegreetraces
   if traceInfo.MaxField(trace-499)>10 && traceInfo.MinField(trace-499)<10
       plot(standardMesh,Hella{trace}.A_X_GRID_DD + traceInfo.TraceTemp(trace-499)/200);
       hold on
   end
end
xlim([8,15])
hold off
clearvars trace ans


%%
%Program for generating SmoothedData

for trace = fivedegreetraces
    [Hella{trace}.A_Fit, Hella{trace}.A_gof]=createFit(Hella{trace}.Field,Hella{trace}.A_X,.9999,0,num2str(trace));
end

%%
standardMesh=0.5:0.001:18;
for trace = fivedegreetraces
    Hella{trace}.A_X_GRID = Hella{trace}.A_Fit(standardMesh);
    [Hella{trace}.A_X_GRID_D,Hella{trace}.A_X_GRID_DD] = differentiate(Hella{trace}.A_Fit, standardMesh);
end

%%
figure()
for trace = fivedegreetraces
   if traceInfo.MaxField(trace-499)>10 && traceInfo.MinField(trace-499)<10
       plot(standardMesh,Hella{trace}.A_X_GRID_DD + traceInfo.TraceTemp(trace-499)/200);
       hold on
   end
end
xlim([8,15])
hold off
clearvars trace ans




%%
%Program for generating SmoothedData

for trace = tendegreetraces
    [Hella{trace}.B_Fit, Hella{trace}.B_gof]=createFit(Hella{trace}.Field,Hella{trace}.B_X,.9999,0,num2str(trace));
end

%%
standardMesh=0.5:0.001:18;
for trace = tendegreetraces
    Hella{trace}.B_X_GRID = Hella{trace}.B_Fit(standardMesh);
    [Hella{trace}.B_X_GRID_D,Hella{trace}.B_X_GRID_DD] = differentiate(Hella{trace}.B_Fit, standardMesh);
end

%%
figure()
for trace = tendegreetraces
   if traceInfo.MaxField(trace-499)>10 && traceInfo.MinField(trace-499)<10
       plot(standardMesh,Hella{trace}.B_X_GRID_DD + traceInfo.TraceTemp(trace-499)/200);
       hold on
   end
end
xlim([8,15])
hold off
clearvars trace ans

%%
figure()
for trace = tendegreetraces
   if traceInfo.MaxField(trace-499)>10 && traceInfo.MinField(trace-499)<10
       Hella{trace}.B_Residuals = Hella{trace}.B_X - Hella{trace}.B_Fit(Hella{trace}.Field);
       plot(Hella{trace}.Field,Hella{trace}.B_Residuals+ traceInfo.TraceTemp(trace-499)/400000);
       hold on
   end
end
xlim([8,17])
hold off
clearvars trace ans
