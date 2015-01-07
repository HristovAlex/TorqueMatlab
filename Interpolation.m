%%
%Program for generating SmoothedData

for trace = tendegreetraces
    structname = strcat('Hella',num2str(trace));

    lhs=strcat('[',structname,'.A_Fit, ',structname,'.A_gof]');
    rhs=strcat('=createFit(',structname,'.Field, ',structname,'.A_X,',num2str(.9999),',0);');
    
    eval(strcat(lhs,rhs));
end
%%
%all traces at 10 degrees
figure()
hold on
for trace = tendegreetraces
    structname = strcat('Hella',num2str(trace));
    x=strcat(structname,'.A_Fit');
    y='deriv2';
    eval(strcat('plot(',x,',"deriv2"')');
end

hold off