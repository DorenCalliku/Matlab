%{
Expectations are the ambitions a person has.
These expectations are based on the personality traits and the options the person has when it comes to partners.
expect_const is the threshold for the arising of the expectations.
%}

function expect = expect( personality, stability, options, female, male, personality_diff)

    [no_male,no_female,factors] = size(personality);
    
    % Middle-way stability is what a couple can like
    stab_avg = ones( no_male,no_female);
    for i = (1: no_male)
        stab_avg(i,:) = (female(:,factors)+repmat(male(i,factors),no_female,1))./2;
    end

    % expectations drive relationships 
    % they are made of the difference where we are at to where we want to go
    % the difference in options between the couple and the personality difference, which does not help
    expect = ((stab_avg - stability) - (options./min(no_male,no_female))-personality_diff/factors); % max abs of it can be -3 
    return
end
