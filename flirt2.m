%{
Options are possible partners that the people can have based on the matrix of relationships. 
partner is the factor of connecting with somebody. 
%}

function opt = flirt2(stability, personality_diff, relationship_constant,consideration_constant)

    [no,no_1] = size(stability);
    
    
    male_opt       = repmat( sum((stability>relationship_constant).*(personality_diff<consideration_constant), 2),  1,no_1);
    female_opt     = repmat( sum((stability>relationship_constant).*(personality_diff<consideration_constant), 1),    no,1);
    
    opt = abs(female_opt-male_opt);
    
    return
end