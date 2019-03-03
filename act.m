%{
Actions are supposedly affected by happiness(stability) and expectations.
They are the main currency of a healthy relationship. 
Most of the time though they are result of expectations - so they are forced.

Major happiness in life is getting to positive delusional phase where actions mean less, and presence means more. 
To get to that phase, based on personality traits difference, there is a constant of stability to be passed. 
%}

function actions = act(expectations, rounds)
    % based on rounds the relationship has been going on actions mean more or less. 
    % in the beginning you over-react, in the end you do not care.
    %((rounds<10).*2 + (rounds<30|rounds>=10)+ (rounds>30)*0.5)
    actions = ((rounds<10).*2 + (rounds<30 & rounds>=10)+ (rounds>30)*0.5).*expectations ;
    return
end
