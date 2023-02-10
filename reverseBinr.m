function [binSum]= reverseBinr(numOctet)
%converts an array representing binary digits to decimal 

binSum=0;
for i = length(numOctet):-1:1
   if numOctet(i) == 1
        binSum= binSum +2.^(length(numOctet)-i);
   end
end

end


