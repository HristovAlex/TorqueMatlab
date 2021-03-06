

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
%       In cases for the first and last traces there is no error bar;
%       uncertainties taken from start of upsweep and end of downsweep
%   TraceTempRange: Max deviation between temps at start of the next temp
%       sweep and the end of the previous one.
%   SweepDirection: +1 for increasing and starts at 0
%                   -1 for decreasing and ends at 0
%                   0 o.w.
%   Next(Preceding)Up(Down)Sweep: used for the above calculation of
%       temperature for a trace.



for trace = 500:609
    traceInfo.Index(trace-499)=trace;
    
    traceInfo.traceLength(trace-499)= length(Hella(trace).Field);
    traceInfo.traceTime(trace-499)  = Hella(trace).Timestamp(traceInfo.traceLength(trace-499));

    traceInfo.FieldSweepAngle(trace-499)= angleOfFieldSweep(Hella(trace));

    traceInfo.MaxField(trace-499) = round(max(Hella(trace).Field),1);
    traceInfo.MinField(trace-499) = round(min(Hella(trace).Field),1);
    
    if traceInfo.MaxField(trace-499)==0
        traceInfo.IsTempSweep(trace-499) = 1;
        traceInfo.PrecedingTempSweep(trace-499) = trace;
    elseif trace==500
         traceInfo.PrecedingTempSweep(trace-499) = NaN;
    else
        traceInfo.IsTempSweep(trace-499) = 0;
        traceInfo.PrecedingTempSweep(trace-499) = traceInfo.PrecedingTempSweep(trace-500) ;
    end
    
    temps = Hella(trace).Temp;
    endtemps = temps(traceInfo.traceLength(trace-499)-10:traceInfo.traceLength(trace-499));
    
    traceInfo.EndMaxTemp(trace-499) = max(endtemps);
    traceInfo.EndMinTemp(trace-499) = min(endtemps);
    traceInfo.StartMaxTemp(trace-499) = max(temps(1:10));
    traceInfo.StartMinTemp(trace-499) = min(temps(1:10));
    
    traceInfo.EndField(trace-499) =  round(Hella(trace).Field(traceInfo.traceLength(trace-499)),1);
    traceInfo.StartField(trace-499) = round(Hella(trace).Field(1),1);
    
    traceInfo.SweepDirection(trace-499) = 0;
    if (traceInfo.FieldSweepAngle(trace-499)>0 && traceInfo.MinField(trace-499)==0)
        if traceInfo.StartField(trace-499) == traceInfo.MaxField(trace-499)
            traceInfo.SweepDirection(trace-499) = -1;
            traceInfo.PrecedingDownSweep(trace-499) = trace;
            traceInfo.NextDownSweep(trace-499) = trace;
        else
            traceInfo.SweepDirection(trace-499) = 1;
            traceInfo.PrecedingUpSweep(trace-499) = trace;
            traceInfo.NextUpSweep(trace-499) = trace;
        end
    end
    
    if trace==500
        traceInfo.PrecedingUpSweep(trace-499) = NaN;
        traceInfo.PrecedingDownSweep(trace-499) = NaN;
    elseif traceInfo.SweepDirection(trace-499) ==0
        traceInfo.PrecedingUpSweep(trace-499) = traceInfo.PrecedingUpSweep(trace-500);
        traceInfo.PrecedingDownSweep(trace-499) = traceInfo.PrecedingDownSweep(trace-500);
    elseif traceInfo.SweepDirection(trace-499) == -1
        traceInfo.PrecedingUpSweep(trace-499) = traceInfo.PrecedingUpSweep(trace-500);
    elseif traceInfo.SweepDirection(trace-499) == 1
        traceInfo.PrecedingDownSweep(trace-499) = traceInfo.PrecedingDownSweep(trace-500);
    end
    
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
    
    if trace==609
        traceInfo.NextUpSweep(trace-499) = NaN;
        %traceInfo.NextDownSweep(trace-499) = NaN;
    elseif traceInfo.SweepDirection(trace-499) ==0
        traceInfo.NextUpSweep(trace-499) = traceInfo.NextUpSweep(trace+1-499);
        traceInfo.NextDownSweep(trace-499) = traceInfo.NextDownSweep(trace+1-499);
    elseif traceInfo.SweepDirection(trace-499) == -1
        traceInfo.NextUpSweep(trace-499) = traceInfo.NextUpSweep(trace+1-499);
    elseif traceInfo.SweepDirection(trace-499) == 1
        traceInfo.NextDownSweep(trace-499) = traceInfo.NextDownSweep(trace+1-499);
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
    else
        beforeIndex = traceInfo.PrecedingUpSweep(trace-499)-499;
        afterIndex  = traceInfo.NextDownSweep(trace-499)-499;
        if beforeIndex >0 && afterIndex>0
            traceInfo.TraceTemp(trace-499)=(traceInfo.StartMaxTemp(beforeIndex)+...
                                            traceInfo.StartMinTemp(beforeIndex) +...
                                            traceInfo.EndMaxTemp(afterIndex)+...
                                            traceInfo.EndMinTemp(afterIndex))/4;
            traceInfo.TraceTempRange(trace-499)= max(...
                abs(traceInfo.EndMaxTemp(afterIndex)-traceInfo.StartMinTemp(beforeIndex)),...
                abs(traceInfo.EndMinTemp(afterIndex)-traceInfo.StartMaxTemp(beforeIndex)));

        end 

    end
end

clearvars temps structname trace endtemps afterIndex beforeIndex

traceInfo.fivedegreetraces = traceInfo.Index(abs(traceInfo.FieldSweepAngle-4.925) < 1e-4);
traceInfo.tendegreetraces = traceInfo.Index(abs(traceInfo.FieldSweepAngle-9.85) < 1e-4);
traceInfo.tempsweeptraces = traceInfo.Index(traceInfo.IsTempSweep==1);




%%
clearvars x y trace ans structname timestampOffset
