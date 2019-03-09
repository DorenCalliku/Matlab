%{
In order to change the people's perception about us we manipulate. 
We show something else of what we are, just so to impress others and to improve their understanding.
%}

function lie = manipulate(personality, rounds)
    lie = (rounds>=30).* personality + (rounds>10 & rounds<=30).*personality*1.3 + (rounds<10).* personality*2;
    return
end