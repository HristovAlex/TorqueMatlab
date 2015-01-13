%% 

for trace = 500:609
    filename = strcat('HellaJHP_.',num2str(trace));
    Hella(trace)=importTorqueFile(filename);
end

clearvars filename trace