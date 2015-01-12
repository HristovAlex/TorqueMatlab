function [ angle ] = angleOfFieldSweep( TraceStruct )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    angle = nan;
    if range(TraceStruct.Field)> 1
        angle = mean(TraceStruct.Position)/360*4.925;
    end
end

