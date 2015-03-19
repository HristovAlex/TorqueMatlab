%%

%%
f=figure('Color',[1 1 1])
temps=H1.temps(H1.B>1);
field=H1.B(H1.B>1);

for nu = 0.4:0.05:0.7
    for TMAX = 0.125:0.025:0.35
        f=fit((temps(temps<TMAX).^(1/nu))',field(temps<TMAX)','poly1') ;
        q=coeffvalues(f);
        if nu <= 0.45
            plot(q(2),TMAX,'ks','MarkerFaceColor',[0.3 0.3 0.3],'MarkerSize',12)
        elseif nu <= 0.55
            plot(q(2),TMAX,'ks','MarkerFaceColor',[0.4 0.4 0.4],'MarkerSize',12)
        elseif nu <= 0.65
            plot(q(2),TMAX,'ks','MarkerFaceColor',[0.5 0.5 0.5],'MarkerSize',12)
        elseif nu <= 0.75
            plot(q(2),TMAX,'ks','MarkerFaceColor',[0.6 0.6 0.6],'MarkerSize',12)
        elseif nu <= 0.85
            plot(q(2),TMAX,'ks','MarkerFaceColor',[0.7 0.7 0.7],'MarkerSize',12)
        end
        
        hold on
    end
end
%xlim([8.8,9.3])
xlabel('$$H_0$$ estimate','FontSize',24,'Interpreter','latex')
ylabel('Max Temp in Fitting','FontSize',24,'Interpreter','latex')
text(9.17,0.12,'$$\nu=0.4$$','FontSize',24,'Interpreter','latex')
text(9.11,0.12,'$$\nu=0.7$$','FontSize',24,'Interpreter','latex')
ylim([0,0.5])
title('Estimating $$H_0$$ for x=0.01','FontSize',24,'Interpreter','latex')
)
%%


%%
% 9.136 to 9.156

figure('Color','w')
g=axes('Position',[0.2 0.2 0.7 0.7]);
j=0;
whichp=( (log(field-9.15)>-2.5) + (field<9.5) > 1 );


for H0 =  9.15%9.145:0.001:9.155
    j=j+1;
    logfields=log(field-H0);
    
    plot(logfields(whichp),log(temps(whichp)),'o');hold on;
    f=fit(logfields(whichp)',log(temps(whichp))','poly1');
    q=coeffvalues(f);
    plot(f)
    crap(j)=q(1);

end
xlabel('$$log(H-H_0)$$','FontSize',24,'Interpreter','latex')
ylabel('$$log(T)$$','FontSize',24,'Interpreter','latex')
text(-1.8,-2.2,'$$\nu=0.5565$$','FontSize',24,'Interpreter','latex')

%%
