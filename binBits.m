function [numBits] =  binBits(binArray)
%This function will only return values of binArray that start from 1
numBits=[];
%Using for loop to start the array from 1's until end of array 
for i = 1:length(binArray)
    if binArray(i) == 1
        for j=i:length(binArray)
        numBits=[numBits binArray(j)];
        end
        break
    end
end