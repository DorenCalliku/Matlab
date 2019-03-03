%{
Find the way to create a meaningful model about people's personalities. 
Personality(economic_stability, psychological_stability, colority, ambitions)
Create the personality matrix. 

number of factors affecting the personality
factors = 4; % Entered as an argument to the function.
%}

function [male, female, personality] = create_perfect_matches(no_male,no_female, factors)
    
    % for simplicity - assume there same number of males and females
    male   = rand(no_male,factors);
    %male(factors,factors) = -1;
    female = male;
    
    % increasing similarity increases the personality correlation because of this trick
    personality = ones( no_male,no_female, factors);
    for i = (1: no_male)
        personality(i,:,:)= abs(female-repmat(male(i,:),no_female,1));
    end
    
    % CAREFUL with correlation - not changed after changing personality
    % find how similar are these people in the grid in one by one comparison
    % used the square root of the sum of squares for some reason unknown to humanity, divide by two to rescale to 0,1 range. 
    %correlation = sqrt( sum( personality.^2 ,3))./sqrt(factors);
    
    return
end
