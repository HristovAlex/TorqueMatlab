%% 
Hella = cell(609);
for trace = 500:609
    filename = strcat('HellaJHP_.',num2str(trace));
    Hella{trace}=importTorqueFile(filename);
end

%%
%build trace database 
%   traceLength: Number of points in the trace
%   traceTime: last timestamp value
%   FieldSweepAngle: Angle at which the field sweep is taken, returns NaN
%       if the sweep is not a field sweep
%   MaxField: Maximum field of the trace, rounded to .1T
%   MinField: Minimum field of the trace, rounded to .1T
%   MaxAngle: Maximum angle of the trace, rounded to .1deg
%   MinAngle: Minimum angle of the sweep, rounded to .1deg
%   IsTempSweep: 1 if field is 0 throughout, 0 else
%   PrecedingTempSweep: Index value of the Previous temp trace
%   NextTempSweep: Index value of the next temp trace
%   EndMaxTemp: Max Temp amongst last 10 data points
%   EndMinTemp: Min Temp Amongst last 10 data points
%   StartMaxTemp: Max Temp amongst first 10 data points
%   StartMinTemp: Min Temp Amongst first 10 data points
%   EndField: Field Value at end of trace
%   StartField: Field Value at start of trace
%   TraceTemp: Average of the temps at the start of the next temp sweep and
%       the end of the previous one
%   TraceTempRange: Max deviation between temps at start of the next temp
%       sweep and the end of the previous one.




for trace = 500:609
    traceInfo.Index(trace-499)=trace;
    
    traceInfo.traceLength(trace-499)= length(Hella{trace}.Field);
    traceInfo.traceTime(trace-499)  = Hella{trace}.Timestamp(traceInfo.traceLength(trace-499));

    traceInfo.FieldSweepAngle(trace-499)= angleOfFieldSweep(Hella{trace});

    traceInfo.MaxField(trace-499) = round(max(Hella{trace}.Field),1);
    traceInfo.MinField(trace-499) = round(min(Hella{trace}.Field),1);
    
    if traceInfo.MaxField(trace-499)==0
        traceInfo.IsTempSweep(trace-499) = 1;
        traceInfo.PrecedingTempSweep(trace-499) = trace;
    elseif trace==500
         traceInfo.PrecedingTempSweep(trace-499) = NaN;
    else
        traceInfo.IsTempSweep(trace-499) = 0;
        traceInfo.PrecedingTempSweep(trace-499) = traceInfo.PrecedingTempSweep(trace-500) ;
    end
    
    temps = Hella{trace}.Temp;
    endtemps = temps(traceInfo.traceLength(trace-499)-10:traceInfo.traceLength(trace-499));
    
    traceInfo.EndMaxTemp(trace-499) = max(endtemps);
    traceInfo.EndMinTemp(trace-499) = min(endtemps);
    traceInfo.StartMaxTemp(trace-499) = max(temps(1:10));
    traceInfo.StartMinTemp(trace-499) = min(temps(1:10));
    
    traceInfo.EndField(trace-499) =  round(Hella{trace}.Field(traceInfo.traceLength(trace-499)),1);
    traceInfo.StartField(trace-499) = round(Hella{trace}.Field(1),1);
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

clearvars temps structname trace endtemps afterIndex beforeIndex
%%



%%
%identify trace subsets
fivedegreetraces = traceInfo.Index(abs(traceInfo.FieldSweepAngle-4.925) < 1e-4);
tendegreetraces = traceInfo.Index(abs(traceInfo.FieldSweepAngle-9.85) < 1e-4);
tempsweeptraces = traceInfo.Index(traceInfo.IsTempSweep==1);




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
