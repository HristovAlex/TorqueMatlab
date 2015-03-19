%%

test=DFilter(1,4,1024,traceInfo,CFilter(1,5,1024,traceInfo,BFilter(2,8,1024,traceInfo,AFilter(2,8,1024,traceInfo,HellaInterp10))));

%%
f=figure('Color',[1 1 1])
f.Position(3:4) = [800 600]; 
subplot(2,2,3)
for trace = traceInfo.reducedtendegreetraces
    [~,locs_Swave] = findpeaks(-test(trace).C_FilteredD2,...
        'MinPeakHeight',max(-test(trace).C_FilteredD2)/1.4,...
        'MinPeakDistance',200);
    test(trace).H1C =0;
    hold on
    plot(test(trace).Field,-test(trace).C_FilteredD2+test(trace).Temp/1e9)
    if test(trace).Temp<.700
        plot(test(trace).Field(locs_Swave(1)),...
            -test(trace).C_FilteredD2(locs_Swave(1))+test(trace).Temp/1e9,...
            'rs','MarkerFaceColor','b');
        
        test(trace).H1C = test(trace).Field(locs_Swave(1));
        test(trace).H1Cindex = locs_Swave(1);
        
    elseif test(trace).Temp<.780
        plot(test(trace).Field(locs_Swave(3)),...
            -test(trace).C_FilteredD2(locs_Swave(3))+test(trace).Temp/1e9,...
            'rs','MarkerFaceColor','b');
        
        test(trace).H1C = test(trace).Field(locs_Swave(3));
        test(trace).H1Cindex = locs_Swave(3);
    end
end

xlabel('Field (T)','FontSize',30);
ylabel('$$\frac{d^2 \tau}{dH^2} +$$ T','FontSize',30,'Interpreter','Latex');
title('3.5%V','FontSize',30)

subplot(2,2,2)
for trace = traceInfo.reducedtendegreetraces
    [~,locs_Swave] = findpeaks(-test(trace).B_FilteredD2,...
        'MinPeakHeight',max(-test(trace).B_FilteredD2)/1.5,...
        'MinPeakDistance',20);
    
    hold on
    plot(test(trace).Field,-test(trace).B_FilteredD2+test(trace).Temp/2e8)
    plot(test(trace).Field(locs_Swave),...
        -test(trace).B_FilteredD2(locs_Swave)+test(trace).Temp/2e8,...
        'rs','MarkerFaceColor','b');
    
    test(trace).H1B = test(trace).Field(locs_Swave(1));
    test(trace).H1Bindex = locs_Swave(1);
end
xlabel('Field (T)','FontSize',30);
ylabel('$$\frac{d^2 \tau}{dH^2} +$$ T','FontSize',30,'Interpreter','Latex');
title('1%V','FontSize',30)
ylim([0 5e-9])

subplot(2,2,1)
for trace = traceInfo.reducedtendegreetraces
    [~,locs_Swave] = findpeaks(test(trace).A_FilteredD2,...
        'MinPeakHeight',max(test(trace).A_FilteredD2)/1.5,...
        'MinPeakDistance',20);
    
    hold on
    plot(test(trace).Field,test(trace).A_FilteredD2+test(trace).Temp/2e8)
    plot(test(trace).Field(locs_Swave),...
        test(trace).A_FilteredD2(locs_Swave)+test(trace).Temp/2e8,...
        'rs','MarkerFaceColor','b');
    
    test(trace).H1Aindex = locs_Swave(1);
    test(trace).H1A = test(trace).Field(locs_Swave(1));
end
xlabel('Field (T)','FontSize',30);
ylabel('$$\frac{d^2 \tau}{dH^2} +$$ T','FontSize',30,'Interpreter','Latex');
title('0%V','FontSize',30)

subplot(2,2,4)
for trace = traceInfo.reducedtendegreetraces
    [~,locs_Swave] = findpeaks(test(trace).D_FilteredD2,...
        'MinPeakHeight',max(test(trace).D_FilteredD2)/1.0001,...
        'MinPeakDistance',20);
    
    hold on
    plot(test(trace).Field,test(trace).D_FilteredD2+test(trace).Temp/9e8)
    test(trace).H1D = 0;
    
    if test(trace).Temp>0.2 && test(trace).Temp<0.56
    plot(test(trace).Field(locs_Swave),...
        test(trace).D_FilteredD2(locs_Swave)+test(trace).Temp/9e8,...
        'rs','MarkerFaceColor','b');
        test(trace).H1D = test(trace).Field(locs_Swave(1));
        test(trace).H1Dindex = locs_Swave(1);
    end
end
xlabel('Field (T)','FontSize',30);
ylabel('$$\frac{d^2 \tau}{dH^2} +$$ T','FontSize',30,'Interpreter','Latex');
title('10%V','FontSize',30)
%%



for trace = traceInfo.reducedtendegreetraces
    
    H1.temps(trace)=test(trace).Temp;
    H1.A(trace)=test(trace).H1A;
    H1.B(trace)=test(trace).H1B;
    H1.C(trace)=test(trace).H1C;
    H1.D(trace)=test(trace).H1D;
    
    H1.tempERR(trace)=test(trace).TempUncertainty;
    H1.AERR(trace)=1/8*1/2;
    H1.BERR(trace)=1/8*1/2;
    H1.CERR(trace)=1/5*1/2;
    H1.DERR(trace)=1/4*1/2;
   
end
%%
figure('Color',[1 1 1]); 
hold on
xyerrorbar(H1.A(H1.A>1),H1.temps(H1.A>1),H1.AERR(H1.A>1),H1.tempERR(H1.A>1),'bd')
xyerrorbar(H1.B(H1.B>1),H1.temps(H1.B>1),H1.BERR(H1.B>1),H1.tempERR(H1.B>1),'gd')
xyerrorbar(H1.C(H1.C>1),H1.temps(H1.C>1),H1.CERR(H1.C>1),H1.tempERR(H1.C>1),'rd')
xyerrorbar(H1.D(H1.D>1),H1.temps(H1.D>1),H1.DERR(H1.D>1),H1.tempERR(H1.D>1),'kd')
xlabel('Field (T)','FontSize',22,'Interpreter','latex')
ylabel('Temperature (K)','FontSize',22,'Interpreter','latex')
text(10,0.6,'0%','FontSize',22)
text(11,0.5,'1%','FontSize',22)
text(11.7,0.42,'3.5%','FontSize',22)
text(12.6,0.3,'10%','FontSize',22)
%%title('H_1(T) for x = 0, 0.001, 0.0035, 0.1')
% L=legend('x=0','x=0.01','x=0','x=0.1');
% L.FontSize=22;
%xlim([9,15])
%ylim([0,1])

%%
figure
for trace = traceInfo.reducedtendegreetraces
    [~,locs_Swave] = findpeaks(test(trace).A_FilteredD2,...
        'MinPeakHeight',max(test(trace).A_FilteredD2)/1.5,...
        'MinPeakDistance',20);
    
    hold on
    plot(test(trace).Field,test(trace).A_X_Interp+test(trace).Temp/2e4)
    plot(test(trace).Field(locs_Swave),...
        test(trace).A_X_Interp(locs_Swave)+test(trace).Temp/2e4,...
        'rs','MarkerFaceColor','b');
    
    test(trace).H1Aindex = locs_Swave(1);
    test(trace).H1A = test(trace).Field(locs_Swave(1));
end

%%