%{
Find the way to create a meaningful model about people's personalities. 
Personality(economic_stability, psychological_stability, colority,..., stability_desire(ambition))
Create the personality matrix. 
%}

function [male, female, personality] = create( male, female, no_male, no_female, factors,rand_factor, stable_factor)

    

    male(:,factors)   = rand(  no_male,1) * rand_factor + stable_factor;
    female(:,factors) = rand(no_female,1) * rand_factor + stable_factor;

    % increasing similarity increases the personality correlation because of this trick
    personality = ones( no_male,no_female, factors);
    for i = (1: no_male)
        personality(i,:,:)= abs(female-repmat(male(i,:),no_female,1));
    end
    
    %correlation = sqrt( sum( personality.^2 ,3))./sqrt(factors);
    
    return
end