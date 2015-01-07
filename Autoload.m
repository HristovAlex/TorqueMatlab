

%% 
for trace = 500:609
    filename = strcat('HellaJHP_.',num2str(trace));
    structname = strcat('Hella',num2str(trace));
    eval(strcat(structname,' = importTorqueFile(filename);'));
end

%% 
Hella = cell(609);
for trace = 500:609
    filename = strcat('HellaJHP_.',num2str(trace));
    Hella{trace}=importTorqueFile(filename);
end
%%
%build trace database 
%   FS_Angle: Angle at which the field sweep is taken, returns NaN if the
%       sweep is not a field sweep
%   MaxField: Maximum field of the trace, rounded to .1T
%   MinField: Minimum field of the trace, rounded to .1T
%   MaxAngle: Maximum angle of the trace, rounded to .1deg
%   MinAngle: Minimum angle of the sweep, rounded to .1deg
%   IsTempSweep: 1 if field is 0 throughout, 0 else
%   traceLength: Number of points in the trace
%   traceTime: last timestamp value


for trace = 500:609
    traceInfo.Index(trace-499)=trace;
    
    structname = strcat('Hella',num2str(trace));
    
    traceInfo.FS_Angle(trace-499) = eval(strcat('angleOfFieldSweep(',structname,')'));
    
    traceInfo.MaxField(trace-499) = eval(strcat('round(max(',structname,'.Field),1)'));
    traceInfo.MinField(trace-499) = eval(strcat('round(min(',structname,'.Field),1)'));
    
    traceInfo.MaxAngle(trace-499) = round(eval(strcat('max(',structname,'.Position)'))/360*4.925,1);
    traceInfo.MinAngle(trace-499) = round(eval(strcat('min(',structname,'.Position)'))/360*4.925,1);
    
    if traceInfo.MaxField(trace-499)==0
        traceInfo.IsTempSweep(trace-499) = 1;
        traceInfo.PrecedingTempSweep(trace-499) = trace;
    elseif trace==500
         traceInfo.PrecedingTempSweep(trace-499) = NaN;
    else
        traceInfo.IsTempSweep(trace-499) = 0;
        traceInfo.PrecedingTempSweep(trace-499) = traceInfo.PrecedingTempSweep(trace-500) ;
    end
    
    traceInfo.traceLength(trace-499)= eval(strcat('length(',structname,'.Field)'));
    traceInfo.traceTime(trace-499)= eval(strcat(structname,'.Timestamp(', num2str(traceInfo.traceLength(trace-499)) ,')'));

    temps = eval(strcat(structname,'.Temp'));
    endtemps = temps(traceInfo.traceLength(trace-499)-10:traceInfo.traceLength(trace-499));
    
    traceInfo.EndMaxTemp(trace-499) = max(endtemps);
    traceInfo.EndMinTemp(trace-499) = min(endtemps);
    traceInfo.StartMaxTemp(trace-499) = max(temps(1:10));
    traceInfo.StartMinTemp(trace-499) = min(temps(1:10));
    
    field = eval(strcat(structname,'.Field'));
    endfield = field(traceInfo.traceLength(trace-499));
    
    traceInfo.EndField(trace-499) =  round(endfield,1);
    traceInfo.StartField(trace-499) = round(field(1),1);

end




for trace = 609:-1:500
    structname = strcat('Hella',num2str(trace));
    
    if traceInfo.MaxField(trace-499)==0
        traceInfo.NextTempSweep(trace-499) = trace;
    elseif trace==609
         traceInfo.NextTempSweep(trace-499) = NaN;
    else
        traceInfo.NextTempSweep(trace-499) = traceInfo.NextTempSweep(trace+1-499) ;
    end
end


for trace = 500:609
    traceInfo.TraceTemp(trace-499)=nan;
    traceInfo.TraceTempRange(trace-499)=nan;
    beforeIndex = traceInfo.PrecedingTempSweep(trace-499)-499;
    afterIndex  =traceInfo.NextTempSweep(trace-499)-499;
    if beforeIndex >0 && afterIndex>0
        traceInfo.TraceTemp(trace-499)=(traceInfo.EndMaxTemp(beforeIndex)+...
                                        traceInfo.EndMinTemp(beforeIndex) +...
                                        traceInfo.StartMaxTemp(afterIndex)+...
                                        traceInfo.StartMinTemp(afterIndex))/4;
        traceInfo.TraceTempRange(trace-499)= max(...
            abs(traceInfo.EndMaxTemp(beforeIndex)-traceInfo.StartMinTemp(afterIndex)),...
            abs(traceInfo.EndMinTemp(beforeIndex)-traceInfo.StartMaxTemp(afterIndex)));
    end 

end

%%
%identify trace subsets
tracenumbers = 500:609;
fivedegreetraces = tracenumbers(abs(traceInfo.FS_Angle-4.925) < 1e-4);
tendegreetraces = tracenumbers(abs(traceInfo.FS_Angle-9.85) < 1e-4);
tempsweeptraces = tracenumbers(traceInfo.IsTempSweep==1);




%%
%%
%%
%%
%%
%%
%%%%%%%%                               EXPLORATORY ANALYSIS FOR TRACE
%%%%%%%%                               TYPE IDENTIFICATION
%%
%%
%all traces at 5 degrees
figure()
hold on
for trace = fivedegreetraces
    structname = strcat('Hella',num2str(trace));
    x=strcat(structname,'.Field');
    y=strcat(structname,'.A0_X');
    eval(strcat('plot(',x,',',y,')'));
end

hold off

%%
%all traces at 10 degrees
figure()
hold on
for trace = tendegreetraces
    structname = strcat('Hella',num2str(trace));
    x=strcat(structname,'.Field');
    y=strcat(structname,'.A0_X');
    eval(strcat('plot(',x,',',y,')'));
end

hold off

%%
% all the temperature sweeps plotted consecutively on a common time axis
figure()
hold on
timestampOffset = 0;
for trace = tempsweeptraces
    structname = strcat('Hella',num2str(trace));
    
    x=strcat(structname,'.Timestamp+timestampOffset');
    y=strcat(structname,'.Temp');
    eval(strcat('plot(',x,',',y,')'));
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
for trace = tracenumbers
    structname = strcat('Hella',num2str(trace));
    x=strcat(structname,'.Timestamp+timestampOffset');
    y=strcat(structname,'.Temp');
    eval(strcat('plot(',x,',',y,')'));
    timestampOffset = timestampOffset + traceInfo.traceTime(trace-499);
end
 
hold off
