

%%

fldNms = fieldnames(Hella(510));

for trace = [510,514,518,522]
    for i = 1:length(fldNms)
        fld = fldNms{i};
        if strcmp(fld,'Timestamp')
            Hella(trace).(fld) = cat(1,...
                Hella(trace-1).(fld),...
                Hella(trace).(fld)+traceInfo.traceTime(trace-500),...
                Hella(trace+1).(fld)+traceInfo.traceTime(trace-500)+traceInfo.traceTime(trace-499));
        else
            Hella(trace).(fld) = cat(1,Hella(trace-1).(fld),Hella(trace).(fld),Hella(trace+1).(fld));
        end
    end
end
clearvars trace ans II xx x y i fld fldNms

%%
% clear 509,511,513,515,517,519,521,523


%to do
%%
% reduced set of 10 degree traces
traceInfo.reducedtendegreetraces=traceInfo.Index((abs(traceInfo.FieldSweepAngle-9.85) < 1e-4) & (traceInfo.SweepDirection == 1));
traceInfo.reducedtendegreetraces(1)=traceInfo.reducedtendegreetraces(1)+1;
traceInfo.reducedtendegreetraces(2)=traceInfo.reducedtendegreetraces(2)+1;

% reduced set of 5 degree traces
traceInfo.reducedfivedegreetraces=traceInfo.Index((abs(traceInfo.FieldSweepAngle-4.925) < 1e-4) & (traceInfo.SweepDirection == -1));
traceInfo.reducedfivedegreetraces(1)=traceInfo.reducedfivedegreetraces(1)-1;
traceInfo.reducedfivedegreetraces(2)=traceInfo.reducedfivedegreetraces(2)-1;


%%







%%
figure

for trace=traceInfo.reducedtendegreetraces
    [ff,ia,ic] = unique(Hella(trace).Field);
    plot(ff,Hella(trace).A_X(ia));
    plot(ff,Hella(trace).B_X(ia));
    plot(ff,Hella(trace).C_X(ia));
    plot(ff,Hella(trace).D_X(ia));
    hold on
end
xlim([1,17])
xlabel('Field(T)')
ylabel('\tau \propto \Delta V_x (V)')
title('Raw Data at 10\circ')
hold off
clearvars ic ia ff trace


%%
figure
for trace=traceInfo.reducedfivedegreetraces
    [ff,ia,ic] = unique(Hella(trace).Field);
    plot(ff,Hella(trace).A_X(ia));
    plot(ff,Hella(trace).B_X(ia));
    plot(ff,Hella(trace).C_X(ia));
    plot(ff,Hella(trace).D_X(ia));
    hold on
end
xlim([1,17])
hold off
clearvars ic ia ff trace
xlabel('Field(T)')
ylabel('\tau \propto \Delta V_x (V)')
title('Raw Data at 5\circ')

%%
standardMesh=0.5:0.001:15;
%%


for trace=traceInfo.reducedtendegreetraces
    [ff,ia,ic] = unique(Hella(trace).Field);
    HellaInterp10(trace).Field=standardMesh;
    HellaInterp10(trace).A_X_Interp = interp1(ff,Hella(trace).A_X(ia),standardMesh,'linear');
    HellaInterp10(trace).B_X_Interp = interp1(ff,Hella(trace).B_X(ia),standardMesh,'linear');
    HellaInterp10(trace).C_X_Interp = interp1(ff,Hella(trace).C_X(ia),standardMesh,'linear');
    HellaInterp10(trace).D_X_Interp = interp1(ff,Hella(trace).D_X(ia),standardMesh,'linear');
    HellaInterp10(trace).Temp = traceInfo.TraceTemp(trace-499);
    HellaInterp10(trace).TempUncertainty = traceInfo.TraceTempRange(trace-499);
end

for trace=traceInfo.reducedfivedegreetraces
    [ff,ia,ic] = unique(Hella(trace).Field);
    HellaInterp5(trace).Field=standardMesh;
    HellaInterp5(trace).A_X_Interp = interp1(ff,Hella(trace).A_X(ia),standardMesh,'spline');
    HellaInterp5(trace).B_X_Interp = interp1(ff,Hella(trace).B_X(ia),standardMesh,'spline');
    HellaInterp5(trace).C_X_Interp = interp1(ff,Hella(trace).C_X(ia),standardMesh,'spline');
    HellaInterp5(trace).D_X_Interp = interp1(ff,Hella(trace).D_X(ia),standardMesh,'spline');
    HellaInterp5(trace).Temp = traceInfo.TraceTemp(trace-499);
    HellaInterp5(trace).TempUncertainty = traceInfo.TraceTempRange(trace-499);
end

clearvars ia ic ff trace



%%
f=figure('name', 'RawData Raw Torque on Grid at 10 Degrees');
f.Color=[1 1 1];
title('torque at 10\circ')
for trace = traceInfo.reducedtendegreetraces
    subplot(2,2,1)
    title('0%V');xlabel('Field(T)');ylabel('\tau \propto \Delta V_x (V)');
    plot(HellaInterp10(trace).Field, HellaInterp10(trace).A_X_Interp+HellaInterp10(trace).Temp/7000)
    hold on
    subplot(2,2,2)
    title('1%V');xlabel('Field(T)');ylabel('\tau \propto \Delta V_x (V)');
    plot(HellaInterp10(trace).Field, -HellaInterp10(trace).B_X_Interp+HellaInterp10(trace).Temp/3000)
    hold on
    subplot(2,2,3)
    title('3.5%V');xlabel('Field(T)');ylabel('\tau \propto \Delta V_x (V)');
    plot(HellaInterp10(trace).Field, -HellaInterp10(trace).C_X_Interp+HellaInterp10(trace).Temp/9000)
    hold on
    subplot(2,2,4)
    title('10%V');xlabel('Field(T)');ylabel('\tau \propto \Delta V_x (V)');
    plot(HellaInterp10(trace).Field, HellaInterp10(trace).D_X_Interp+HellaInterp10(trace).Temp/7000)
    hold on
end

figure('name', 'RawData Raw Torque on Grid at 5 Degrees')
for trace = traceInfo.reducedfivedegreetraces
    subplot(2,2,1)
    title('0%V');xlabel('Field(T)');ylabel('\tau \propto \Delta V_x (V)');
    plot(HellaInterp5(trace).Field, HellaInterp5(trace).A_X_Interp+HellaInterp5(trace).Temp/7000)
    hold on
    subplot(2,2,2)
    title('1%V');xlabel('Field(T)');ylabel('\tau \propto \Delta V_x (V)');
    plot(HellaInterp5(trace).Field, -HellaInterp5(trace).B_X_Interp+HellaInterp5(trace).Temp/3000)
    hold on
    subplot(2,2,3)
    title('3.5%V');xlabel('Field(T)');ylabel('\tau \propto \Delta V_x (V)');
    plot(HellaInterp5(trace).Field, -HellaInterp5(trace).C_X_Interp+HellaInterp5(trace).Temp/9000)
    hold on
    subplot(2,2,4)
    title('10%V');xlabel('Field(T)');ylabel('\tau \propto \Delta V_x (V)','FontSize',22);
    plot(HellaInterp5(trace).Field, HellaInterp5(trace).D_X_Interp+HellaInterp5(trace).Temp/7000)
    hold on
end
clearvars trace

%%
% plot(Hella(518).Field, Hella(518).A_X,'linewidth',5)
% xlabel('Field (T)')
% ylabel('\tau \propto \Delta V_x (V)');
% title('Torque vs Field: Ba_3Mn_2O_8 at 22(\pm 3) mK')
% xlim([0,18])
% xlim([0,15])