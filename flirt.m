%{
Options are possible partners that the people can have based on the matrix of relationships. 
partner is the factor of connecting with somebody. 
%}

function opt = flirt(stability)
    partner = 0.3;
    [no,no_1] = size(stability);
    %female_options = sum(stability> partner, 1)
    %male_options   = sum(stability> partner, 2)
    male_opt       = repmat(sum(stability> partner, 2),  1,no_1);
    female_opt     = repmat(sum(stability> partner, 1),    no,1);
    opt = abs(female_opt-male_opt);
    return
end