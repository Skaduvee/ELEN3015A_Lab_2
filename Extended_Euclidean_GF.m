function [g, a, b] = Extended_Euclidean_GF(v, u, field)
remainderIsZero = false;
pol1 = u;
pol2 = v;
remainder = [1];
remainders = {v,u};
a_variable = {[0],[-Inf]};
b_variable = {[-Inf],[0]};
i = 1;

while ~remainderIsZero
    j = 1;
    %Iterate for the a(x) and b(x).
    if i >=3 && j == 1 %Only need to start the algorithm when i >= 3 as the first two iterations are initisialised.

        %get multiplication of previous remainder multiplied by the
        %quotient. Then take the floor of that. Which would just be the
        %quotient.
        p1 = cell2mat(remainders(1, i - 2));
        p2 = cell2mat(remainders(1, i - 1));
        quotient= floor(gfdeconv(p1, p2, field));
        product = gfconv(p2, quotient, field);

        %Add the current remainder(1, i-2) to the product calculated above.
        %Addition can be used as they are in the Galois Field and addition
        %is the same as subtraction.
        remainder = gfadd(p1, product, field);
        remainders{end + 1} = remainder;
        quotient = floor(gfdeconv(v,u,field));

        %storing the v value. 
        % This is so once the remainder is zero it will automatically have the gcd. 
        % Instead of searching through an array for it. It is also used to
        % calculate the quotient variable for the next iteration which is
        % needed for the next a(x) and b(x).
        v = u; 

        %storing the u value. Stored so the quotient for the 
        % next iteration can be calculated.
        u = remainder; 

        % a(x) is dependent on the a variable from i - 2 and 
        % i - 1. The i - 1 a(x) polynomial is then multiplied by the quotient
        % found from the v(x) and u(x) polynomial stored in the previous iteration.
        % Same goes for b(x).
        a1 = cell2mat(a_variable(1, i - 2));
        a2 = cell2mat(a_variable(1, i - 1));
        product = gfconv(a2,quotient,field);
        a_variable{end + 1} = gfadd(a1,product,field);


        b1 = cell2mat(b_variable(1, i - 2));
        b2 = cell2mat(b_variable(1, i - 1));
        product = gfconv(b2,quotient,field);
        b_variable{end + 1} = gfadd(b1,product,field);

        j = j -1;
    end
    for k = 1:size(remainder,2) %Checking to see if the remainder is full of -Inf elements. If so then the remainder is zero.
        if remainder(1,k) == -Inf
            remainderIsZero = true;
        else
            remainderIsZero = false;
            break;
        end
    end
    i = i + 1;
end
g = v;

%Since there is an extra check to see if the remainder is zero the 
% a(x) and b(x) polynomials will be from the i - 2 iteration.
a = cell2mat(a_variable(1, i - 2));
b = cell2mat(b_variable(1, i - 2));
end