%%
for trace = traceInfo.reducedtendegreetraces
    [HellaInterp10(trace).A_Conv, HellaInterp10(trace).A_ConvD, HellaInterp10(trace).A_ConvD2]=...
        gConvolve(HellaInterp10(trace).A_X_Interp,25);
    [HellaInterp10(trace).B_Conv, HellaInterp10(trace).B_ConvD, HellaInterp10(trace).B_ConvD2]=...
        gConvolve(HellaInterp10(trace).B_X_Interp,25);
    [HellaInterp10(trace).C_Conv, HellaInterp10(trace).C_ConvD, HellaInterp10(trace).C_ConvD2]=...
        gConvolve(HellaInterp10(trace).C_X_Interp,25);
    [HellaInterp10(trace).D_Conv, HellaInterp10(trace).D_ConvD, HellaInterp10(trace).D_ConvD2]=...
        gConvolve(HellaInterp10(trace).D_X_Interp,25);
end


clearvars trace ans


%%
figure('name', 'Second Derivative obtained by convolution on the grid 10 Degrees')
for trace = traceInfo.reducedtendegreetraces
    subplot(2,2,1)
    plot(HellaInterp10(trace).Field, HellaInterp10(trace).A_ConvD+HellaInterp10(trace).Temp/2e6)
    xlim([0,14])
    hold on
    subplot(2,2,2)
    plot(HellaInterp10(trace).Field, -HellaInterp10(trace).B_ConvD+HellaInterp10(trace).Temp/2e6)
    xlim([0,14])
    hold on
    subplot(2,2,3)
    plot(HellaInterp10(trace).Field, -HellaInterp10(trace).C_ConvD+HellaInterp10(trace).Temp/2e6)
    xlim([0,14])
    hold on
    subplot(2,2,4)
    plot(HellaInterp10(trace).Field, HellaInterp10(trace).D_ConvD+HellaInterp10(trace).Temp/2e6)
    xlim([0,14])
    hold on
end

clearvars trace ans

%%
figure('name', 'Second Derivative obtained by convolution on the grid 10 Degrees','Color',[1 1 1])
title('x=0 @ 10\circ')
for trace = traceInfo.reducedtendegreetraces
    
    plot(HellaInterp10(trace).Field, HellaInterp10(trace).A_Conv+HellaInterp10(trace).Temp/5e4)
    hold on
end
xlim([7.5,13])
%ylim([-1e-4 1e-4])
title('$$x=0$$ @ $$10^\circ$$','Interpreter','Latex','FontSize',22)
xlabel('Field(T)','Interpreter','Latex','FontSize',22)
ylabel('$$\tau$$+Temperature','Interpreter','Latex','FontSize',22)
clearvars trace ans

%%
figure('name', 'Second Derivative obtained by convolution on the grid 10 Degrees','Color',[1 1 1])
title('x=0 @ 10\circ')
for trace = traceInfo.reducedtendegreetraces
    
    plot(HellaInterp10(trace).Field, HellaInterp10(trace).A_ConvD+HellaInterp10(trace).Temp/5e6)
    hold on
end
xlim([7.5,13])
%ylim([-1e-4 1e-4])
title('$$x=0$$ @ $$10^\circ$$','Interpreter','Latex','FontSize',22)
xlabel('Field(T)','Interpreter','Latex','FontSize',22)
ylabel('$$\frac{d\tau}{dH}$$+Temperature','Interpreter','Latex','FontSize',22)
clearvars trace ans

%%
figure('name', 'Second Derivative obtained by convolution on the grid 10 Degrees','Color',[1 1 1])
title('x=0 @ 10\circ')
for trace = traceInfo.reducedtendegreetraces
    
    plot(HellaInterp10(trace).Field, HellaInterp10(trace).A_ConvD2+HellaInterp10(trace).Temp/3e8)
    hold on
end
xlim([7.5,13])
%ylim([-1e-4 1e-4])
title('$$x=0$$ @ $$10^\circ$$','Interpreter','Latex','FontSize',22)
xlabel('Field(T)','Interpreter','Latex','FontSize',22)
ylabel('$$\frac{d^2\tau}{dH^2}$$+Temperature','Interpreter','Latex','FontSize',22)
clearvars trace ans


%%
for trace = traceInfo.reducedfivedegreetraces
    [HellaInterp5(trace).A_Conv, HellaInterp5(trace).A_ConvD, HellaInterp5(trace).A_ConvD2]=...
        gConvolve(HellaInterp5(trace).A_X_Interp,40);
    [HellaInterp5(trace).B_Conv, HellaInterp5(trace).B_ConvD, HellaInterp5(trace).B_ConvD2]=...
        gConvolve(HellaInterp5(trace).B_X_Interp,30);
    [HellaInterp5(trace).C_Conv, HellaInterp5(trace).C_ConvD, HellaInterp5(trace).C_ConvD2]=...
        gConvolve(HellaInterp5(trace).C_X_Interp,40);
    [HellaInterp5(trace).D_Conv, HellaInterp5(trace).D_ConvD, HellaInterp5(trace).D_ConvD2]=...
        gConvolve(HellaInterp5(trace).D_X_Interp,60);
end


clearvars trace ans



figure('name', 'Second Derivative obtained by convolution on the grid 10 Degrees')
for trace = traceInfo.reducedfivedegreetraces
    subplot(2,2,1)
    plot(HellaInterp5(trace).Field, HellaInterp5(trace).A_ConvD2+HellaInterp5(trace).Temp/2e8)
    xlim([0,14])
    hold on
    subplot(2,2,2)
    plot(HellaInterp5(trace).Field, -HellaInterp5(trace).B_ConvD2+HellaInterp5(trace).Temp/6e8)
    xlim([0,14])
    hold on
    subplot(2,2,3)
    plot(HellaInterp5(trace).Field, -HellaInterp5(trace).C_ConvD2+HellaInterp5(trace).Temp/6e8)
    xlim([0,14])
    hold on
    subplot(2,2,4)
    plot(HellaInterp5(trace).Field, HellaInterp5(trace).D_ConvD2+HellaInterp5(trace).Temp/2e9)
    xlim([0,14])
    hold on
end

clearvars trace ans