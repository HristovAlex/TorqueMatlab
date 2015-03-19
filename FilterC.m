P=AFilter(j,k*j,2^i,traceInfo,HellaInterp10);
%%
for i = 8:10
    for j = 0.25:0.25:1.5
        for k = 2:5
            AFilter(j,k*j,2^i,traceInfo,HellaInterp10);
        end
    end
end
clearvars i j k
