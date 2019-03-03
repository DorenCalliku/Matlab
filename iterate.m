%{
Rounds are the number of times the relationships has been going on. 
It affects the effect of the actions one takes. 
%}

function rounds = iterate(stability,factor, rounds)
    % the number of rounds is equal to the previous number of rounds + 1 for people continuing, and +1 for people starting from beginning. 
    rounds = (stability>factor).*stability + rounds;
    return
end
