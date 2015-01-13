%%
% 33 traces at 10 degrees
% 24 traces at 5 degrees
traceInfo.A_10_SSparams=ones(33)-.000001;
traceInfo.A_5_SSparams =ones(24)-.000001;

traceInfo.B_10_SSparams=ones(33)-.000001;
traceInfo.B_5_SSparams =ones(24)-.000001;

traceInfo.C_10_SSparams=ones(33)-.000001;
traceInfo.C_5_SSparams =ones(24)-.000001;

traceInfo.D_10_SSparams=ones(33)-.000001;
traceInfo.D_5_SSparams =ones(24)-.000001;


%%
%Smooth the data and residuals
i=1;
for trace = traceInfo.tendegreetraces
    [Hella{trace}.A_Fit, Hella{trace}.A_gof]=createFit(Hella{trace}.Field,Hella{trace}.A_X,traceInfo.A_10_SSparams(i),0,num2str(trace));
    [Hella{trace}.B_Fit, Hella{trace}.B_gof]=createFit(Hella{trace}.Field,Hella{trace}.B_X,traceInfo.B_10_SSparams(i),0,num2str(trace));
    [Hella{trace}.C_Fit, Hella{trace}.C_gof]=createFit(Hella{trace}.Field,Hella{trace}.C_X,traceInfo.C_10_SSparams(i),0,num2str(trace));
    [Hella{trace}.D_Fit, Hella{trace}.D_gof]=createFit(Hella{trace}.Field,Hella{trace}.D_X,traceInfo.D_10_SSparams(i),0,num2str(trace));

    Hella{trace}.A_Residuals = Hella{trace}.A_X - Hella{trace}.A_Fit(Hella{trace}.Field);
    Hella{trace}.B_Residuals = Hella{trace}.B_X - Hella{trace}.B_Fit(Hella{trace}.Field);
    Hella{trace}.C_Residuals = Hella{trace}.C_X - Hella{trace}.C_Fit(Hella{trace}.Field);
    Hella{trace}.D_Residuals = Hella{trace}.D_X - Hella{trace}.D_Fit(Hella{trace}.Field);
  
    i=i+1;
end

clearvars i trace

%%
%interpolate functions onto a standard grid
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


clearvars trace
%%
% smooth the residuals estimate fit error
i=1;
for trace = traceInfo.tendegreetraces
    [Hella{trace}.A_Residuals_smth,Hella{trace}.A_Residuals_smthD,Hella{trace}.A_Residuals_smthDD] = gConvolve(Hella{trace}.A_Residuals,10);
    traceInfo.A_bias(i) = sum(abs(Hella{trace}.A_Residuals_smth))/traceInfo.traceLength(trace-499);
    
    [Hella{trace}.B_Residuals_smth,Hella{trace}.B_Residuals_smthD,Hella{trace}.B_Residuals_smthDD] = gConvolve(Hella{trace}.B_Residuals,10);
    traceInfo.B_bias(i) = sum(abs(Hella{trace}.B_Residuals_smth))/traceInfo.traceLength(trace-499);
    
    [Hella{trace}.C_Residuals_smth,Hella{trace}.C_Residuals_smthD,Hella{trace}.C_Residuals_smthDD] = gConvolve(Hella{trace}.C_Residuals,10);
    traceInfo.C_bias(i) = sum(abs(Hella{trace}.C_Residuals_smth))/traceInfo.traceLength(trace-499);
    
    [Hella{trace}.D_Residuals_smth,Hella{trace}.D_Residuals_smthD,Hella{trace}.D_Residuals_smthDD] = gConvolve(Hella{trace}.D_Residuals,10);
    traceInfo.D_bias(i) = sum(abs(Hella{trace}.D_Residuals_smth))/traceInfo.traceLength(trace-499);
    
    i=i+1;
end
%%

% plot second derivatives from gridded values
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
% plot raw residuals
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

%%

figure
hold on
plot(traceInfo.tendegreetraces,traceInfo.A_bias,'b')
plot(traceInfo.tendegreetraces,traceInfo.B_bias,'g')
plot(traceInfo.tendegreetraces,traceInfo.C_bias,'r')
plot(traceInfo.tendegreetraces,traceInfo.D_bias,'k')
hold off
clearvars trace ans i 

%%
figure
i=1;
for trace = traceInfo.tendegreetraces
    [Hella{trace}.A_Residuals_smth,Hella{trace}.A_Residuals_smthD,Hella{trace}.A_Residuals_smthDD] = gConvolve(Hella{trace}.A_Residuals,10);
    traceInfo.A_bias(i) = sum(abs(Hella{trace}.A_Residuals_smth))/traceInfo.traceLength(trace-499);
    if traceInfo.MaxField(trace-499)>10 && traceInfo.MinField(trace-499)<10
        plot(Hella{trace}.Field,Hella{trace}.A_Residuals_smth + traceInfo.TraceTemp(trace-499)/3e7);
        hold on
    end
    i=i+1;
end







