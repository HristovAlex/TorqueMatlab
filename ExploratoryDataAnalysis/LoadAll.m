%% 
Hella = cell(609);
for trace = 500:609
    filename = strcat('HellaJHP_.',num2str(trace));
    Hella{trace}=importTorqueFile(filename);
end