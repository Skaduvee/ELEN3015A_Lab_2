function [g,a,b] = Extended_Euclidean_Int(v,u)
remainderIsZero = false;
remainder = 1;
remainders = [v,u];
a_variable = [1,0];
b_variable = [0,1];
i = 1;
while ~remainderIsZero
    j = 1;     
    %Iterate for the a and b.
    if i >=3 && j == 1 %Only need to start the algorithm when i >= 3 as the first two iterations are initisialised.
        %The current iterations remainder is dependent on the remainder at
        %i - 2 and i - 1. The floor of the remainder at i - 2 divided by 
        % i - 1 is then the quotient for this iteration.
        remainder = remainders(1, i - 2) - (remainders(1, i - 1) * floor(remainders(1, i - 2)/remainders(1, i - 1)));
        remainders(1,i) = remainder; %Storing the remainder so it can be used in future iterations.
        quotient = floor(v/u);

        %storing the v value. 
        % This is so once the remainder is zero it will automatically have the gcd. 
        % Instead of searching through an array for it. It is also used to
        % calculate the quotient variable for the next iteration which is
        % needed for the next a and b variables.
        v = u;

        %storing the u value. Stored so the quotient for the
        % next iteration can be calculated.
        u = remainder; 
        
        %the a variable is dependent on the a variable from i - 2 and 
        % i - 1. The i - 1 a variable is then multiplied by the quotient
        % found from the v and u variable stored in the previous
        % iteration. Same goes for b.
        a_variable(1,i) = a_variable(1, i - 2) - (a_variable(1, i - 1) * quotient);
        b_variable(1,i) = b_variable(1, i - 2) - (b_variable(1, i - 1) * quotient);
        j = j -1;
    end
    if remainder == 0
        remainderIsZero = true;
    end
    i = i + 1;
end
g = v;

%Since there is an extra check to see if the remainder is zero the 
% a and b variables will be from the i - 2 iteration.
a = a_variable(1, i - 2);  
b = b_variable(1, i - 2);
end