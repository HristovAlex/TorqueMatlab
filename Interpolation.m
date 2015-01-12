%%
%Program for generating SmoothedData

for trace = traceInfo.tendegreetraces
    [Hella{trace}.A_Fit, Hella{trace}.A_gof]=createFit(Hella{trace}.Field,Hella{trace}.A_X,.9999,0,num2str(trace));
    [Hella{trace}.B_Fit, Hella{trace}.B_gof]=createFit(Hella{trace}.Field,Hella{trace}.B_X,.9999,0,num2str(trace));
    [Hella{trace}.C_Fit, Hella{trace}.C_gof]=createFit(Hella{trace}.Field,Hella{trace}.C_X,.999,0,num2str(trace));
    [Hella{trace}.D_Fit, Hella{trace}.D_gof]=createFit(Hella{trace}.Field,Hella{trace}.D_X,.999,0,num2str(trace));

    Hella{trace}.A_Residuals = Hella{trace}.A_X - Hella{trace}.A_Fit(Hella{trace}.Field);
    Hella{trace}.B_Residuals = Hella{trace}.B_X - Hella{trace}.B_Fit(Hella{trace}.Field);
    Hella{trace}.C_Residuals = Hella{trace}.C_X - Hella{trace}.C_Fit(Hella{trace}.Field);
    Hella{trace}.D_Residuals = Hella{trace}.D_X - Hella{trace}.D_Fit(Hella{trace}.Field);
end

%%
standardMesh=0.5:0.001:18;
for trace = traceInfo.tendegreetraces
    Hella{trace}.A_X_GRID = Hella{trace}.A_Fit(standardMesh);
    [Hella{trace}.A_X_GRID_D,Hella{trace}.A_X_GRID_DD] = differentiate(Hella{trace}.A_Fit, standardMesh);
    
    Hella{trace}.B_X_GRID = Hella{trace}.B_Fit(standardMesh);
    [Hella{trace}.B_X_GRID_D,Hella{trace}.B_X_GRID_DD] = differentiate(Hella{trace}.B_Fit, standardMesh);
    
    Hella{trace}.C_X_GRID = Hella{trace}.C_Fit(standardMesh);
    [Hella{trace}.C_X_GRID_D,Hella{trace}.C_X_GRID_DD] = differentiate(Hella{trace}.C_Fit, standardMesh);
    
    Hella{trace}.D_X_GRID = Hella{trace}.D_Fit(standardMesh);
    [Hella{trace}.D_X_GRID_D,Hella{trace}.D_X_GRID_DD] = differentiate(Hella{trace}.D_Fit, standardMesh);
end

%%
figure()
for trace = traceInfo.tendegreetraces
   if traceInfo.MaxField(trace-499)>10 && traceInfo.MinField(trace-499)<10
       plot(standardMesh,Hella{trace}.A_X_GRID_DD + traceInfo.TraceTemp(trace-499)/200);
       hold on
   end
end
xlim([8,15])
hold off
clearvars trace ans

figure()
for trace = traceInfo.tendegreetraces
   if traceInfo.MaxField(trace-499)>10 && traceInfo.MinField(trace-499)<10
       plot(standardMesh,Hella{trace}.B_X_GRID_DD + traceInfo.TraceTemp(trace-499)/200);
       hold on
   end
end
xlim([8,15])
hold off
clearvars trace ans

figure()
for trace = traceInfo.tendegreetraces
   if traceInfo.MaxField(trace-499)>10 && traceInfo.MinField(trace-499)<10
       plot(standardMesh,Hella{trace}.C_X_GRID_DD + traceInfo.TraceTemp(trace-499)/200);
       hold on
   end
end
xlim([8,15])
hold off
clearvars trace ans

figure()
for trace = traceInfo.tendegreetraces
   if traceInfo.MaxField(trace-499)>10 && traceInfo.MinField(trace-499)<10
       plot(standardMesh,Hella{trace}.D_X_GRID_DD + traceInfo.TraceTemp(trace-499)/1000);
       hold on
   end
end
xlim([8,15])
hold off
clearvars trace ans


%%
figure()
for trace = traceInfo.tendegreetraces
   if traceInfo.MaxField(trace-499)>10 && traceInfo.MinField(trace-499)<10
       plot(Hella{trace}.Field,Hella{trace}.A_Residuals+ traceInfo.TraceTemp(trace-499)/400000);
       hold on
   end
end
xlim([8,17])
hold off
clearvars trace ans

figure()
for trace = traceInfo.tendegreetraces
   if traceInfo.MaxField(trace-499)>10 && traceInfo.MinField(trace-499)<10
       plot(Hella{trace}.Field,Hella{trace}.B_Residuals+ traceInfo.TraceTemp(trace-499)/400000);
       hold on
   end
end
xlim([8,17])
hold off
clearvars trace ans

figure()
for trace = traceInfo.tendegreetraces
   if traceInfo.MaxField(trace-499)>10 && traceInfo.MinField(trace-499)<10
       plot(Hella{trace}.Field,Hella{trace}.C_Residuals+ traceInfo.TraceTemp(trace-499)/400000);
       hold on
   end
end
xlim([8,17])
hold off
clearvars trace ans

figure()
for trace = traceInfo.tendegreetraces
   if traceInfo.MaxField(trace-499)>10 && traceInfo.MinField(trace-499)<10
       plot(Hella{trace}.Field,Hella{trace}.D_Residuals+ traceInfo.TraceTemp(trace-499)/400000);
       hold on
   end
end
xlim([8,17])
hold off
clearvars trace ans









