%% Relationship-Options connections
clear;clc; clf;

no_male   = 6;
no_female = 6;
factors   = 4;
stability_factor = 0.5;
iterations = 50;

[male,female, personality]= create_perfect_matches(no_male,no_female, factors);
stability   = zeros( no_male,no_female);
rounds      = zeros(no_male,no_female);

%%
for i = (1:iterations)
    
    % checking my options of flirting
    options      = flirt(stability);
    
    % creating my expectations for each combination
    expectations = expect(options, personality, stability);
    
    % based on expectations I act
    actions      = act(expectations, rounds);
    
    % my actions affect my stability with each possible partner
    stability    = stability + actions.*rand(size(actions),0,1);
    stability    = stability/max(stability,[],'all');
    % I choose the best relationship and decrease the other people's chances
    status       = stabilize(stability);
    
    stability    = stability .* status + (stability .* ~status)/3; 
    
    % increase the rounds the stable relationship has run
    rounds       = iterate(stability, stability_factor, rounds);
    
    % plot
    imagesc(stability); 
    
    colorbar;
    axis equal off;
    pause(1);
    
end
