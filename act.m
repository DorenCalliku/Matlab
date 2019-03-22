%{
Actions are supposedly affected by happiness(stability) and expectations.
They are the main currency of a healthy relationship. 
Most of the time though they are result of expectations - so they are forced.

Major happiness in life is getting to positive delusional phase where actions mean less, and presence means more. 
To get to that phase, based on personality traits difference, there is a constant of stability to be passed. 
%}

function actions = act(expectations, rounds,jump_start, delusion_effect, normal, lower_limit, upper_limit)
    % based on rounds the relationship has been going on, actions mean more or less. 
    importance = (rounds<lower_limit)*jump_start + (rounds<upper_limit & rounds>=lower_limit)*normal+ (rounds>=upper_limit)*delusion_effect;
    actions = importance.*expectations;
    return
end
