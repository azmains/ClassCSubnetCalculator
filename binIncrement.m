function [increment]= binIncrement(numOctet)
%converts an array representing binary digits to decimal 

increment=0;
for i = length(numOctet):-1:1
   if numOctet(i) == 1
        increment= increment +2.^(length(numOctet)-i);
        break
   end
end

end
