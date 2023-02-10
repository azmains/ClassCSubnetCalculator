function [out] = binr(num)
%%this function converts from decimal to binary 

%initialise variables
x=[];
box=num;  
binary=[];

%if binary is all zero then disp binary matrix as below or else divide
%number and add 1 and 0
if num==0
    binary=[0 0 0 0 0 0 0];
else
    while box ~= 1
        if mod(box,2) == 0
            x=[x 0];
        else
            x=[x 1];
            box=box-1;
        end
        box=box/2;
    end
end

if num ~= 0
    x=[x 1];
   
    if ~isempty(x)
        while length(x) < 8
            x=[x 0];
        end
        while length(x) > 8
            break
        end
       
    end
    
    for j = length(x):-1:1
       binary= [binary x(j)];
    end
   
end

out=binary;


