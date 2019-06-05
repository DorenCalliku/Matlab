%{
In order to change the people's perception about us we manipulate. 
We show something else of what we are, just so to impress others and to improve their understanding.
%}

function lie = manipulate(personality, rounds,lower_limit, upper_limit, lower_lie, upper_lie)
    lie = (rounds>=upper_limit).* personality + (rounds>=lower_limit & rounds<upper_limit).*personality*upper_lie + (rounds<lower_limit).* personality*lower_lie;
    return
end
