%{
Expectations are the ambitions a person has.
These expectations are based on the personality traits and the options the person has when it comes to partners.
expect_const is the threshold for the arising of the expectations.
%}

function expect = expect(options, personality, stability)
    % expect_const = 0.2;
    % no_males,no_females = size(stability); 
    [no_male,no_female,factors] = size(personality);

    % ambition for the relationship = 1 - abs(a,b) <= shows how much what they both want fits.
    % if it doesn't fit much, then expectations from one side or the other arise.  
    ambition = 1-(personality(:,:,factors));
    
    % expectations factor is the distance between what you want, and what the stability is,
    % + if ambition differences exist then, depending on these differences increase the expectations limit. 
    % also if there are far more options for one of the sides, expectations arise.
    expect = (ambition - stability) + (((ambition.*2 - stability)>0) .* (options./10));
    return
end
