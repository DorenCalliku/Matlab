%{
Options are possible partners that the people can have based on the matrix of relationships. 
partner is the factor of connecting with somebody. 
%}

function opt = flirt2(stability,personality,personality_diff, partner)

    [no,no_1] = size(stability);
    
    
    male_opt       = repmat( sum((stability>partner).*(personality_diff<0.3), 2),  1,no_1);
    female_opt     = repmat( sum((stability>partner).*(personality_diff<0.3), 1),    no,1);
    
    opt = abs(female_opt-male_opt);
    
    return
end