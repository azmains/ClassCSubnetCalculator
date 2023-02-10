function [rangeRandOutput]=rangeRand(first,last)
%This function randomly generates variables from a set range given
rangeRandOutput =  (first-1) + ceil(rand()*(last-(first-1)));
end