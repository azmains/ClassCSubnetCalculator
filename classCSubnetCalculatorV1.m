clc
clear
%This program is a subnet calculator for Class C IPs

%Ask user how many times they want to run the program
turns=input("How many Class C IPs do you want to subnet? "); %%use strcmp if it is already there before

%print new line
fprintf("\n")

%Initialize numHost and numNet variables in the loop

    numHost=0;
    numNet=0;
    %Ask user if they want to subnet through networks or hosts 
    option=input("Answer '1' to specify number Networks or answer '2' to specify number of Hosts per network: ");

    %if option is not 1 or 2 then the while loop will ask user again
    %infinitely
    while ~(option ==1 || option == 2)
         option=input("Answer '1' to specify number Networks or answer '2' to specify number of Hosts per network: ");
    end
    
    %if option is 1 then numNet will be converted to binary array using
    %function 'binr'
    if option == 1
        numNet=input("How many networks do you want? ");
        binArray= binr(numNet);
        additionalNets=numNet;
        %Class C networks cannot have number of networks greater than 63
        while (numNet < 1) ||(numNet > 63)
            fprintf("A suitable number of networks and hosts are required otherwise host IPs cannot be allocated \n \n")
            fprintf("The number of networks should be between 1 and 63 \n \n")
            numNet=input("How many networks do you want? ");
            fprintf("\n")
        end
        
        %the function binBits will remove all leading zeroes from the
        %binArray array
        boxBits=binBits(binArray);

        lastOctet=[];
        
        %the for loop will add 1's to the front of a new array last octet
        %for as long as the length of boxBits
        for i = 1:length(boxBits)
            lastOctet=[lastOctet 1];
        end
        %this while loop will add zeroes to the front of the array if the
        %length is not 8 bits
        while length(lastOctet) < 8
            lastOctet=[lastOctet 0];
        end
    end
    %this loop is for option ==2 where the host method is used
    if option == 2
           numHost=input("How many hosts do you want? ");
           binArray= binr(numHost);
           additionalNets=numHost;

        while (numHost < 1) ||(numHost > 126)
            fprintf("A suitable number of networks and hosts are required otherwise host IPs cannot be allocated \n \n")
            fprintf("The number of hosts should be between 1 and 126 \n \n")
            numHost=input("How many hosts do you want? ");
            fprintf("\n")
        end
           binArray= binr(numHost);

            boxBits=binBits(binArray);

            lastOctet=[];
            %As host method is similar to network method it is just 8-
            %length(boxBits)
            for i = 1:(8-length(boxBits))
                lastOctet=[lastOctet 1];
            end

            while length(lastOctet) < 8
                lastOctet=[lastOctet 0];
            end
    end
    %To find subnet mask octet this will get lastoctet and convert it back
    %to integer form
    subnetMaskOctet = reverseBinr(lastOctet);
    
    %Display subnet mask using variable subnetMask
    subnetMask = [255 255 255 subnetMaskOctet];

    %Initialize hostBits variable
    hostBits=0;
    
    %Increment hostbits by 1 for every length of lastOctet
    for i = 1:length(lastOctet)
        if lastOctet(i) == 0
            hostBits=hostBits + 1;
        end
    end
    
    %Randomly generate numbers for octets in Class C range
    firstOctet = rangeRand(192, 223);
    secondOctet = rangeRand(1, 255);
    thirdOctet = rangeRand(1,255);

    %Print values of subnet mask and hostbits
    fprintf("You have been assigned Class C IP: %d.%d.%d.0 \n \n", firstOctet,secondOctet,thirdOctet)
    fprintf("The subnet mask of this IP is: %d.%d.%d.%d /%d \n \n", subnetMask, hostBits)

    %incrementBit is the increment value for last Octet
    incrementBit=binIncrement(lastOctet);
    %initialize networkOctet
    networkOctet=0;

    %Initialize numNetCapacity which is the amount of networks that are
    %possible
    numNetCapacity= 0;
    for i = length(lastOctet):-1:1
        if lastOctet(i)==1
            numNetCapacity=2^(i);
            break
        end
    end
    %Initialise array storeSubnetMask to store subnet values
    storeSubnetIp=[];
    subnetIncrements=0;
    %format the subnet ips like this
    formatOctets= "%d.%d.%d.%d";
    
    %hostIps is initialised and storeSubnetIp array is created using for
    %loop and incrementBit
    hostIps=[];
    for i=1:numNetCapacity
        storeSubnetIp = [storeSubnetIp ; sprintf(formatOctets, firstOctet, secondOctet, thirdOctet, subnetIncrements)];
        for j = 1:incrementBit-2
            %Make sure to not display some variables
            hostIps=[hostIps ; sprintf(formatOctets, firstOctet, secondOctet, thirdOctet, j + subnetIncrements)];
        end
        subnetIncrements=subnetIncrements+incrementBit;
       
    end 
    
    %If option==1 then calculate the additional subnet by subtraction
    if option == 1
        differenceSubnet = length(storeSubnetIp)- numNet;
        for ip = 1:length(storeSubnetIp)
            disp(storeSubnetIp(ip));
            if ip == additionalNets
            fprintf("\nYou have %d additional subnet/s. \n", differenceSubnet);
            end
        end
    else %Or just display the variable
         for ip = 1:length(storeSubnetIp)
            disp(storeSubnetIp(ip));
         end
    end
 


   
